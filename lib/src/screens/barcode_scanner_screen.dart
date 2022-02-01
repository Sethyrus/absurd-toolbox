import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/barcode_scanner/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class BarcodeScannerScreen extends StatefulWidget {
  static const String routeName = '/barcode-scanner';

  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _scannedValue = '';
  bool _isValidLink = false;

  void _initScanner() async {
    FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      false,
      ScanMode.BARCODE,
    ).then((newValue) async {
      if (newValue != '' && newValue != '-1' && _scannedValue != newValue) {
        canLaunch(newValue).then((isValidLink) {
          setState(() {
            _isValidLink = isValidLink;
            _scannedValue = newValue;
          });
        }).catchError((e) {
          setState(() {
            _isValidLink = false;
            _scannedValue = newValue;
          });
        });
      }
    });
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
        child: BarcodeScanner(
          scannedValue: _scannedValue,
          isValidLink: _isValidLink,
        ),
      ),
      fab: FloatingActionButton(
        onPressed: _initScanner,
        child: const Icon(
          Icons.photo_camera,
          color: Colors.black,
        ),
        backgroundColor: Colors.teal.shade300,
      ),
    );
  }
}
