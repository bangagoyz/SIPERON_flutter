import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/AdminBukuTamuComponents.dart';

import 'package:perpus/Components/User/Kunjungan/UserKunjunganComponents.dart';

import 'package:perpus/Screens/User/Kunjungan/KunjunganScanner.dart';
import 'package:perpus/Utils/constants.dart';

class AdminBukuTamuScreen extends StatelessWidget {
  static var routeName = '/admin_buku_tamu_screens';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Buku Tamu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: AdminBukuTamuComponents(),
    );
  }
}
