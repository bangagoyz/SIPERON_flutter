import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perpus/Components/default_button_custom_color.dart';
import 'package:perpus/Screens/Admin/Crud/QRBukuScreen.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class QRBukuForm extends StatefulWidget {
  @override
  State<QRBukuForm> createState() => _QRBukuForm();
}

class _QRBukuForm extends State<QRBukuForm> {
  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    // print(json.encode(dataBuku));
    return Form(
        child: Column(children: [
      QrImageView(
        data: json.encode(QRBukuScreens.dataBuku),
        size: 200,
        backgroundColor: Colors.white,
      ),
      SizedBox(
        height: getProportionateScreenHeight(20),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Judul Buku",
              style: mTitleStyle,
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${QRBukuScreens.dataBuku['judulBuku']}",
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penulis",
              style: mTitleStyle,
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${QRBukuScreens.dataBuku['penulisBuku']}",
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penerbit",
              style: mTitleStyle,
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${QRBukuScreens.dataBuku['penerbit']}",
            )
          ],
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(20),
      ),
    ]));
  }

  void peminjamanProcess(idBuku, idUser) async {
    utilsApps.showDialog(context); //pop up message dialog

    bool status;
    var msg;
    try {
      response = await dio.post(createPeminjaman, data: {
        'idBuku': idBuku,
        'idUser': idUser,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'SUKSES',
          desc: 'Selamat Membaca',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, UserHomeScreen.routeName,
                arguments: UserHomeScreen.userDataLogin);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'GAGAL',
          desc: 'Gagal Meminjam => $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      // print(e);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'GAGAL',
        desc: 'Terjadi Kesalahan Pada Server',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
    // print(response!.data);
  }
}
