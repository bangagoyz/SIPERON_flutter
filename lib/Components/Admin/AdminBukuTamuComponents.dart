import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../../../Screens/User/UserHomeScreen.dart';
import '../../../../api/apiConfig.dart';

class AdminBukuTamuComponents extends StatefulWidget {
  @override
  State<AdminBukuTamuComponents> createState() => _AdminBukuTamuComponents();
}

class _AdminBukuTamuComponents extends State<AdminBukuTamuComponents> {
  Response? response;
  var dio = Dio();
  var dataKunjungan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataKunjungan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(hexColor('#67B26F')),
              Color(hexColor('#4ca2cd'))
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          title: Text(
            "Buku Tamu",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20)),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataKunjungan == null
                        ? 0
                        : dataKunjungan.length, //penghitung item
                    itemBuilder: (BuildContext context, int index) {
                      int reverseIndex = dataKunjungan.length - 1 - index;
                      return cardPeminjaman(dataKunjungan[reverseIndex]);
                    },
                  ),
                )
              ],
            )),
          ),
        )));
  }

  Widget cardPeminjaman(data) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, PeminjamanScreens.routeName,
        //     arguments: data);
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white))),
                child: Image.asset('assets/images/guest.png'),
              ),
              title: Text(
                '${data['dataUser']['nama']}',
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data['dataUser']['email']}',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['tanggal']}',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDataKunjungan() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get('$getAllKunjungan');

      status = response!.data['sukses'];
      msg = response!.data['msg']; //response untuk ambil data dari respon api
      if (status) {
        setState(() {
          dataKunjungan = response!.data['data']; //show datas
          utilsApps.hideDialog(context);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Gagal',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Gagal',
          desc: 'Terjadi Kesalahan Internal',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }
}
