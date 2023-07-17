import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../../../Screens/User/UserHomeScreen.dart';
import '../../../../api/apiConfig.dart';

class DataPeminjamanaUserComponents extends StatefulWidget {
  @override
  State<DataPeminjamanaUserComponents> createState() =>
      _DataPeminjamanaUserComponents();
}

class _DataPeminjamanaUserComponents
    extends State<DataPeminjamanaUserComponents> {
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
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      response = await dio
          .get('$getPeminjamanUser/${UserHomeScreen.userDataLogin['_id']}');

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
