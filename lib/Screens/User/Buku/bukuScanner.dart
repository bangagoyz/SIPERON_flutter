import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;

class bukuScanner extends StatefulWidget {
  static var routeName = '/buku_scanner';
  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<bukuScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  dynamic dinamis;

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(
                bottom: 10,
                child: buildResult(),
              ),
              Positioned(
                top: 20,
                child: buildControlButtons(),
              )
            ],
          ),
        ),
      );

  Widget buildControlButtons() => Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                      snapshot.data! ? Icons.flash_off : Icons.flash_on);
                } else {
                  return Container();
                }
              },
            ),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
          ),
          IconButton(
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(Icons.switch_camera);
                } else {
                  return Container();
                }
              },
            ),
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
          )
        ],
      ));

  Widget buildResult() => Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: Text(
        barcode != null ? 'Result : ${barcode!.code}' : 'Scan QRCode!',
        maxLines: 3,
      ));

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: kColorTeal,
          borderRadius: 10,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) {
      // setState(() => this.barcode = barcode);
      kePeminjaman();
      if (barcode.code != null) {
        String? bangsat = (barcode.code);
        String asu = bangsat!;
        Map<dynamic, dynamic> valueMap = json.decode(asu);
        controller.pauseCamera();

        Navigator.pushNamed(context, PeminjamanScreens.routeName,
            arguments: valueMap);
      }
    });
  }

  kePeminjaman() {
    controller?.pauseCamera();

    // Navigator.pushNamed(context, PeminjamanScreens.routeName,
    //     arguments: );
  }
}
