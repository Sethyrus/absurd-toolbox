import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightScreen extends StatefulWidget {
  static const String routeName = '/flashlight';

  const FlashlightScreen({Key? key}) : super(key: key);

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _hasFlashlight = false;
  bool _isFlashlightOn = false;
  bool _flashlightPending = true;

  @override
  void initState() {
    super.initState();
    initFlashlight();
  }

  @override
  void dispose() {
    if (_hasFlashlight && _isFlashlightOn) TorchLight.disableTorch();
    super.dispose();
  }

  void initFlashlight() async {
    TorchLight.isTorchAvailable().then(
      (hasFlashlight) {
        log("Device has flashlight: $hasFlashlight");
        setState(() {
          _hasFlashlight = hasFlashlight;
          _flashlightPending = false;
        });
      },
    );
  }

  void toggleFlashlight() {
    setState(() {
      _flashlightPending = true;
    });

    if (_isFlashlightOn) {
      TorchLight.disableTorch()
          .then(
        (value) => setState(() {
          _isFlashlightOn = false;
          _flashlightPending = false;
        }),
      )
          .catchError(
        (onError) {
          log("Error turning off flashlight", onError);
          setState(() {
            _flashlightPending = false;
          });
        },
      );
    } else {
      TorchLight.enableTorch()
          .then(
        (value) => setState(() {
          _isFlashlightOn = true;
          _flashlightPending = false;
        }),
      )
          .catchError(
        (onError) {
          log("Error turning on flashlight", onError);
          setState(() {
            _flashlightPending = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere((t) => t.route == FlashlightScreen.routeName);

    return Layout(
      statusBarColor: tool.secondaryColor,
      themeColor: tool.primaryColor,
      themeStyle: tool.themeStyle,
      title: 'Linterna',
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: (!_hasFlashlight && _flashlightPending)
            ? const SizedBox.shrink()
            : Center(
                child: _hasFlashlight
                    ? SizedBox(
                        width: 160,
                        height: 160,
                        child: InkWell(
                          onTap: _flashlightPending ? null : toggleFlashlight,
                          borderRadius: BorderRadius.circular(256),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.purple.shade300,
                              borderRadius: BorderRadius.circular(256),
                            ),
                            child: Icon(
                              _isFlashlightOn
                                  ? Icons.flashlight_off
                                  : Icons.flashlight_on,
                              size: 96,
                            ),
                          ),
                        ),
                      )
                    : const Text("Tu dispositivo no tiene linterna"),
              ),
      ),
    );
  }
}
