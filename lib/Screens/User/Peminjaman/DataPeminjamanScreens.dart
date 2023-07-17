import 'package:flutter/material.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../../../Components/User/Peminjaman/DataPeminjaman/DataPeminjamanUserComponents.dart';

class DataPeminjamanScreens extends StatelessWidget {
  static var routeName = '/data_peminjaman_screens';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Peminjaman Anda",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: DataPeminjamanaUserComponents(),
    );
  }
}
