import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/Crud/InputBuku/InputBukuForm.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:perpus/Components/Login/LoginForm.dart';

import '../../../api/apiConfig.dart';

class peminjaman extends StatefulWidget {
  @override
  _peminjaman createState() => _peminjaman();
}

class _peminjaman extends State<peminjaman> {
  Response? response;
  Response? response2;
  var dio = Dio();
  var dataPeminjaman;
  var dataUser;
  var mapDataUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPeminjaman();
  }

  //tampilan depan keseluruhan
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
      ),
    );
  }

  String extractNameFromData(data) {
    if (data != null && data['_id'] != null) {
      return data['_id'].toString();
    } else {
      return '';
    }
  }

  Widget cardPeminjaman(data) {
    String id = extractNameFromData(data);
    return GestureDetector(
      onTap: () {
        data['dipinjam'] == false
            ? AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                animType: AnimType.SCALE,
                title: 'Perhatian',
                desc: 'Buku sudah dikembalikan',
                btnOkOnPress: () {},
              ).show()
            : AwesomeDialog(
                    context: context,
                    dialogType: DialogType.QUESTION,
                    animType: AnimType.SCALE,
                    title: 'Konfirmasi',
                    desc: 'Konfirmasi Pengembalian?',
                    btnOkOnPress: () {
                      pengembalianProcess(
                          '${data['idBuku']}',
                          '${data['idUser']}',
                          '${data['_id']}',
                          (DateTime.now()).toString());
                    },
                    btnCancelOnPress: () {})
                .show();
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
                  Text(
                    'Status',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  data['dipinjam'] == true
                      ? Text(
                          'Dalam Peminjaman',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Telah Dikembalikan',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
      response = await dio.get('$getAllPeminjaman');

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

  void pengembalianProcess(idBuku, idUser, idPeminjaman, waktu) async {
    utilsApps.showDialog(context); //pop up message dialog

    bool status;
    var msg;
    try {
      response = await dio.post(createPengembalian, data: {
        'idBuku': idBuku,
        'idUser': idUser,
        'idPeminjaman': idPeminjaman,
        'tanggal': waktu
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'SUKSES',
          desc: 'Berhasil',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'GAGAL',
          desc: 'Gagal Mengembalikan => $msg',
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
