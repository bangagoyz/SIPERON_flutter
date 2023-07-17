import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perpus/Screens/User/Buku/DataBukuScreen.dart';
import 'package:perpus/Screens/User/Kunjungan/UserKunjunganScreen.dart';
import 'package:perpus/Screens/User/Peminjaman/DataPeminjamanScreens.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../api/apiConfig.dart';
import 'Peminjaman/CreatePeminjaman/FormPeminjamanComponents.dart';

class UserHomeComponent extends StatefulWidget {
  var dataPeminjaman;
  @override
  _UserHomeComponent createState() => _UserHomeComponent();
}

class _UserHomeComponent extends State<UserHomeComponent> {
  DateTime timeBackPressed = DateTime.now();
  Response? response;
  var dio = Dio();
  var dataPeminjaman;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPeminjaman();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final message = 'Tekan lagi untuk keluar';
            Fluttertoast.showToast(msg: message, fontSize: 18);
            SystemNavigator.pop();
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20)),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Layanan",
                    style: mTitleStyle,
                  ),
                ),
                menuLayanan(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Peminjaman Anda Saat Ini",
                    style: mTitleStyle,
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataPeminjaman == null
                        ? 0
                        : dataPeminjaman.length, //penghitung item
                    itemBuilder: (BuildContext context, int index) {
                      // return cardPeminjaman(dataBuku[index]);
                      return cardPeminjaman(dataPeminjaman[index]);
                    },
                  ),
                )
              ],
            )),
          ),
        ));
  }

  Widget menuLayanan() {
    return Container(
      height: 135,
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DataBukuScreens.routeName);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.only(left: 16),
                  height: 64,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueGrey, width: 1)),
                  child: Row(
                    children: [
                      Image.asset('assets/images/list.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pinjam Buku",
                              style: mServiceTitleStyle,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Cari Buku",
                              style: mServiceSubtitleStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UserKunjunganScreens.routeName);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.only(left: 16),
                  height: 64,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueGrey, width: 1)),
                  child: Row(
                    children: [
                      Image.asset('assets/images/borrow.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Buku Tamu",
                              style: mServiceTitleStyle,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Scan Kunjungan",
                              style: mServiceSubtitleStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DataPeminjamanScreens.routeName);
            },
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              padding: EdgeInsets.only(left: 70),
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueGrey, width: 1)),
              child: Row(
                children: [
                  Image.asset('assets/images/riwayat.png'),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Riwayat Peminjaman Anda",
                          style: mServiceTitleStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Lihat Riwayat Peminjaman",
                          style: mServiceSubtitleStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
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
                child: Image.asset('assets/images/buku1.jpg'),
              ),
              title: Text(
                '${data['dataBuku']['judulBuku']}',
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penulis',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['dataBuku']['judulBuku']}',
                  ),
                  Text(
                    'Penerbit',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['dataBuku']['penerbit']}',
                  ),
                  Text(
                    'Tanggal Pinjam',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['tanggal']}',
                  ),
                  data['dipinjam'] == true
                      ? Text(
                          'Dalam Peminjaman',
                          style: TextStyle(
                              color: kColorYellow, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Telah Dikembalikan',
                          style: TextStyle(
                              color: kColorTeal, fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDataPeminjaman() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response =
          await dio.get('$getLimitUser/${UserHomeScreen.userDataLogin['_id']}');

      status = response!.data['sukses'];
      msg = response!.data['msg']; //response untuk ambil data dari respon api
      if (status) {
        setState(() {
          dataPeminjaman = response!.data['data']; //show datas
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
}
