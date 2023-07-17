import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Screens/Admin/AdminBukuScreen.dart';
import 'package:perpus/Screens/Admin/AdminBukuTamuScreen.dart';
import 'package:perpus/Screens/Admin/peminjaman/AdminPeminjamanScreen.dart';
import 'package:perpus/Screens/User/Buku/DataBukuScreen.dart';
import 'package:perpus/Screens/User/Peminjaman/DataPeminjamanScreens.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../api/apiConfig.dart';

class AdminHomeComponent extends StatefulWidget {
  var dataPeminjaman;
  @override
  _AdminHomeComponent createState() => _AdminHomeComponent();
}

class _AdminHomeComponent extends State<AdminHomeComponent> {
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
          return false;
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
                    "Peminjaman Terbaru",
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
                      int reverseIndex = dataPeminjaman.length - 1 - index;
                      return cardPeminjaman(dataPeminjaman[reverseIndex]);
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
                  Navigator.pushNamed(
                      context, AdminPeminjamanScreens.routeName);
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
                      Image.network(
                          'https://cdn-icons-png.flaticon.com/32/4901/4901662.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Peminjaman",
                              style: mServiceTitleStyle,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Data Peminjaman",
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
                  Navigator.pushNamed(context, AdminBukuTamuScreen.routeName);
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
                      Image.asset('assets/images/guest.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
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
                              "Data kunjungan",
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
              Navigator.pushNamed(context, AdminBukuScreen.routeName);
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
                          "Kelola Buku",
                          style: mServiceTitleStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Tambah, edit dan hapus Buku",
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
    // String id = extractNameFromData(data);
    return GestureDetector(
      onTap: () {
        // AwesomeDialog(
        //         context: context,
        //         dialogType: DialogType.QUESTION,
        //         animType: AnimType.SCALE,
        //         title: 'Konfirmasi',
        //         desc: 'Konfirmasi Pengembalian?',
        //         btnOkOnPress: () {
        //           persetujuan('ya', id);
        //         },
        //         btnCancelOnPress: () {})
        //     .show();
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
                '${data['dataUser']['nama']}',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail Pengguna',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['dataUser']['email']}',
                  ),
                  Text(
                    'Judul Buku',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['dataBuku']['judulBuku']}',
                  ),
                  Text(
                    'Tanggal Peminjaman',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['tanggal']}',
                  ),
                  data['persetujuan'] == null
                      ? Text(
                          'Dalam Peminjaman',
                          style: TextStyle(
                              color: kColorYellow, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Telah Dikembalikan',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
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
      response = await dio.get('$getLimitAll');

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
