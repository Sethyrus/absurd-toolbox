import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/notes/notes_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OCRReader extends StatefulWidget {
  final void Function(String) onRead;

  const OCRReader({Key? key, required this.onRead}) : super(key: key);

  static void initOCR(context, void Function(String) onRead) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => OCRReader(onRead: onRead),
    );
  }

  @override
  State<OCRReader> createState() => _OCRReaderState();
}

class _OCRReaderState extends State<OCRReader> {
  CameraController? _cameraController;
  List<CameraDescription> _availableCameras = [];
  bool _isOCRAvailable = false;
  final textDetector = GoogleMlKit.vision.textDetector();

  @override
  void initState() {
    super.initState();

    availableCameras().then((cameras) {
      _availableCameras = cameras;

      _cameraController = CameraController(
        _availableCameras[0],
        ResolutionPreset.max,
        enableAudio: false,
      );

      _cameraController?.initialize().then((_) {
        setState(() => _isOCRAvailable = true);
      });
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere((t) => t.route == NotesScreen.routeName);

    return SafeArea(
      child: _isOCRAvailable
          ? Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_cameraController!),
                Positioned(
                  right: 0,
                  bottom: 32,
                  left: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      onPressed: () {
                        log("Take picture!");
                        EasyLoading.show();
                        _cameraController?.takePicture().then((image) {
                          log("Camera captured image", image);

                          ImageCropper()
                              .cropImage(
                            sourcePath: image.path,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            androidUiSettings: AndroidUiSettings(
                              hideBottomControls: true,
                              toolbarTitle: 'Recorta el texto',
                              toolbarColor: tool.primaryColor,
                              toolbarWidgetColor: Colors.black,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false,
                            ),
                            iosUiSettings: const IOSUiSettings(
                              minimumAspectRatio: 1.0,
                            ),
                          )
                              .then((file) {
                            log("Cropped image", file);

                            if (file != null) {
                              final inputImage = InputImage.fromFilePath(
                                file.path,
                              );

                              textDetector
                                  .processImage(inputImage)
                                  .then((recognisedText) {
                                List<String> recognizedList = [];

                                for (TextBlock block in recognisedText.blocks) {
                                  recognizedList.add(block.text);
                                }

                                log("OCR text list", recognizedList);

                                widget.onRead(recognizedList.join("\n"));

                                EasyLoading.dismiss();

                                Navigator.of(context).pop();
                              });
                            } else {
                              log("OCR file is null");
                              widget.onRead("");
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                            }
                          });
                        });
                      },
                      child: const Icon(Icons.camera),
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
