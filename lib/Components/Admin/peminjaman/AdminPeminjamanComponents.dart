import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/peminjaman/peminjaman.dart';
import 'package:perpus/Components/Admin/peminjaman/pengembalian.dart';
import 'package:perpus/Screens/Admin/peminjaman/AdminPeminjamanScreen.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../../../Screens/User/UserHomeScreen.dart';
import '../../../../api/apiConfig.dart';

class AdminPeminjamanComponents extends StatefulWidget {
  @override
  State<AdminPeminjamanComponents> createState() =>
      _AdminPeminjamanComponents();
}

class _AdminPeminjamanComponents extends State<AdminPeminjamanComponents> {
  Response? response;
  var dio = Dio();
  var dataPeminjaman;
  var dataUser;
  var mapDataUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
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
              "List Peminjam",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            bottom:
                TabBar(indicatorColor: Colors.white, indicatorWeight: 5, tabs: [
              Tab(
                text: "Peminjaman",
              ),
              Tab(
                text: "Pengembalian",
              )
            ]),
          ),
          body: TabBarView(children: [peminjaman(), pengembalian()])));

  String extractNameFromData(data) {
    if (data != null && data['_id'] != null) {
      return data['_id'].toString();
    } else {
      return '';
    }
  }

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }
}
