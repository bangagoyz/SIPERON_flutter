import 'package:flutter/material.dart';
import 'package:perpus/Components/Register/RegisterForm.dart';
import 'package:perpus/Components/User/Peminjaman/CreatePeminjaman/FormPeminjamanComponents.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

class PeminjamanComponent extends StatefulWidget {
  @override
  _PeminjamanComponent createState() => _PeminjamanComponent();
}

class _PeminjamanComponent extends State<PeminjamanComponent> {
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
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                PeminjamanForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
