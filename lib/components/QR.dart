import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

Widget QR() {
  print("xxxxxxxxxxxxxxxxxxxxxxxxx");
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  return QRView(
    key: qrKey,
    onQRViewCreated: (QRViewController controller) {
      controller.scannedDataStream.listen((scanData) {
        result = scanData;
      });
    },
    overlay: QrScannerOverlayShape(
      borderColor: Colors.orange,
      borderRadius: 10,
      borderLength: 30,
      borderWidth: 10,
      cutOutSize: 250,
    ),
  );
}
