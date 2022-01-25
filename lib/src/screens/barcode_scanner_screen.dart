import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class BarcodeScannerScreen extends StatefulWidget {
  static const String routeName = '/barcode-scanner';

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _scannedValue = '';
  bool _isValidLink = false;

  void startScanning() async {
    String newValue = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      false,
      ScanMode.BARCODE,
    );

    if (newValue != '' && newValue != '-1' && _scannedValue != newValue) {
      bool isValidLink = await canLaunch(newValue);

      setState(() {
        _scannedValue = newValue;
        _isValidLink = isValidLink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.teal.shade400,
      themeColor: Colors.teal.shade300,
      title: 'QR/barcode scan',
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (1 / 6),
        ),
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _scannedValue != ''
              ? [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text('Valor escaneado:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _scannedValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.teal.shade300,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () => Clipboard.setData(
                      ClipboardData(text: _scannedValue),
                    ),
                    child: Text('Copiar al portapapeles'),
                  ),
                  ..._isValidLink
                      ? [
                          ElevatedButton(
                            onPressed: () => launch(_scannedValue),
                            child: Text('Abrir enlace'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.teal.shade300,
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            ),
                          )
                        ]
                      : []
                ]
              : [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Ningún valor escaneado',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    'Pulsa el botón para escanear un QR/código de barras',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
        ),
      ),
      fab: FloatingActionButton(
        onPressed: startScanning,
        child: Icon(
          Icons.photo_camera,
          color: Colors.black,
        ),
        backgroundColor: Colors.teal.shade300,
      ),
    );
  }
}
