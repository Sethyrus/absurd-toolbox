import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BarcodeScanner extends StatefulWidget {
  final String scannedValue;
  final bool isValidLink;

  BarcodeScanner({
    required this.scannedValue,
    required this.isValidLink,
  });

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.scannedValue != ''
          ? [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('Valor escaneado:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.scannedValue,
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
                  ClipboardData(text: widget.scannedValue),
                ),
                child: Text('Copiar al portapapeles'),
              ),
              ...widget.isValidLink
                  ? [
                      ElevatedButton(
                        onPressed: () => launch(widget.scannedValue),
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
    );
  }
}
