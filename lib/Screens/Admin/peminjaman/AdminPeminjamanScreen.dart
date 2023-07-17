import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/peminjaman/AdminPeminjamanComponents.dart';
import 'package:perpus/Components/User/Buku/BukuComponents.dart';
import 'package:perpus/Utils/constants.dart';

class AdminPeminjamanScreens extends StatelessWidget {
  static var routeName = '/peminjaman_admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Peminjaman",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: AdminPeminjamanComponents(),
    );
  }
}
