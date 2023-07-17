import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/Crud/QRBuku/QRBukuForm.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

class QRBukuScreens extends StatelessWidget {
  static var routeName = '/qr_buku_screens';
  static var dataBuku;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataBuku = ModalRoute.of(context)!.settings.arguments as Map;

    // print(dataBuku);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "QRCode Buku",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: QRBukuForm(),
    );
  }
}
