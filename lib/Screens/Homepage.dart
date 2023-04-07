import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homescreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String username = '';

  Future<void> user() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    setState(() {
      username = token.getString('full_name').toString();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.orange,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          ),
          // ElevatedButton(
          //   child: Text('Woolha.com'),
          //   onPressed: () async {
          //     await controller!.toggleFlash();
          //   },
          // ),
          // ElevatedButton(
          //   child: Text('Woolha.com'),
          //   onPressed: () async {
          //     await controller!.resumeCamera();
          //   },
          // ),
          // ElevatedButton(
          //   child: Text('pasuse'),
          //   onPressed: () async {
          //     await controller?.pauseCamera();
          //   },
          // )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        pendinglist_();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future pendinglist_() async {
    var name_code = {result!.code}.toString();
    String value = name_code.substring(2, name_code.length - 2);
    print(value);
    SharedPreferences token = await SharedPreferences.getInstance();
    var name;
    name = token.getString('full_name').toString();
    print(name);
    print(value);
    print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
    var response = await http.post(
        Uri.parse(
            "https://sstlive.thirvusoft.co.in/api/method/expo.expo.custom.api.attendance?user=${name}&name=${value}"),
        headers: {"Authorization": "token 1599e6dcec498c6:ae5a9f65dd361e8"});
    print(response.body);
    print(
        "https://sstlive.thirvusoft.co.in/api/method/expo.expo.custom.api.attendance?user=${name}&name=${value}");
    print(response.statusCode);
    print('pppppppppppppppppppppppppppppppppppppppppppp');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.green,
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const homescreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
    }
    ;
  }
}
