import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/Crud/InputBuku/InputBukuForm.dart';
import 'package:perpus/Screens/Admin/AdminHomeScreen.dart';
import 'package:perpus/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:perpus/Screens/Admin/Crud/QRBukuScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:perpus/Components/Login/LoginForm.dart';

import '../../Screens/Admin/Crud/InputBukuScreen.dart';

class HomeAdminComponent extends StatefulWidget {
  @override
  _HomeAdminComponent createState() => _HomeAdminComponent();
}

class _HomeAdminComponent extends State<HomeAdminComponent> {
  Response? response;
  var dio = Dio();
  var dataBuku; //penampung data getall

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataBuku();
  }

  //tampilan depan keseluruhan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(hexColor('#67B26F')),
            Color(hexColor('#4ca2cd'))
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        title: Text(
          "Kelola Buku",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputBukuScreens.routeName);
            },
            child: Row(children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "Input Data",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ]),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataBuku == null
                        ? 0
                        : dataBuku.length, //penghitung item
                    itemBuilder: (BuildContext context, int index) {
                      return cardDataBuku(dataBuku[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDataBuku(data) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 253, 253)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.asset('assets/images/buku1.jpg'),
          ),
          title: Text(
            '${data['judulBuku']}',
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditBukuScreens.routeName,
                    arguments: data);
              },
              child: Row(children: [
                Icon(
                  Icons.edit,
                  color: kColorYellow,
                ),
                // SizedBox(
                //   width: 3,
                // ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.QUESTION,
                    animType: AnimType.SCALE,
                    title: 'Peringatan',
                    desc: 'Yakin ingin menghapus ${data['judulBuku']} ?.....',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context, AdminHomeScreen.routeName, (route) => false);
                      hapusBukuId('${data['_id']}');
                    }).show();
              },
              child: Row(children: [
                Icon(
                  Icons.delete,
                  color: kColorRedSlow,
                ),
                // SizedBox(
                //   width: 3,
                // ),
                Text(
                  "Hapus",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, QRBukuScreens.routeName,
                    arguments: data);
              },
              child: Row(children: [
                Icon(
                  Icons.qr_code,
                  color: kTextColor,
                ),
                // SizedBox(
                //   width: 3,
                // ),
                Text(
                  "QRCode",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }

  void getDataBuku() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllBuku);

      status = response!.data['sukses'];
      msg = response!.data['msg']; //response untuk ambil data dari respon api
      if (status) {
        setState(() {
          dataBuku = response!.data['data']; //show datas
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
      print(e);
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

  void hapusBukuId(id) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.delete('$hapusBuku/$id');

      status = response!.data['sukses'];
      msg = response!.data['msg']; //response untuk ambil data dari respon api
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Berhasil',
            desc: '$msg',
            btnOkOnPress: () {
              // Navigator.pushAndRemoveUntil(
              //   context, AdminHomeScreen.routeName, (route) => false);
              Navigator.pushNamed(context, AdminHomeScreen.routeName);
              utilsApps.hideDialog(context);
            }).show();
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
      print(e);
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
}
