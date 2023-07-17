import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perpus/Components/default_button_custom_color.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';

class PeminjamanForm extends StatefulWidget {
  @override
  State<PeminjamanForm> createState() => _PeminjamanForm();
}

class _PeminjamanForm extends State<PeminjamanForm> {
  Response? response;
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      Image.asset(
        'assets/images/buku1.jpg',
        width: 300,
        height: 500,
        fit: BoxFit.cover,
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
              "${PeminjamanScreens.dataBuku['judulBuku']}",
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
              "${PeminjamanScreens.dataBuku['penulisBuku']}",
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
              "${PeminjamanScreens.dataBuku['penerbit']}",
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
              "Tahun Terbit",
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
              "${PeminjamanScreens.dataBuku['tahunTerbit']}",
            )
          ],
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(20),
      ),
      DefaultButtonCustomeColor(
        color: kPrimaryColor,
        text: "Pinjam Buku Ini",
        press: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.QUESTION,
            animType: AnimType.RIGHSLIDE,
            title: 'Perhatian!',
            desc: 'Yakin meminjam buku ini?',
            btnOkOnPress: () {
              peminjamanProcess(PeminjamanScreens.dataBuku['_id'],
                  UserHomeScreen.userDataLogin['_id']);
            },
            btnCancelOnPress: () {},
          ).show();
        },
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
        'tanggal': (DateTime.now()).toString()
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
