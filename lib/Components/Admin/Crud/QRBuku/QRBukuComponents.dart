import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/Crud/InputBuku/InputBukuForm.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:perpus/Components/Login/LoginForm.dart';

class QRBukuComponent extends StatefulWidget {
  @override
  _QRBukuComponent createState() => _QRBukuComponent();
}

class _QRBukuComponent extends State<QRBukuComponent> {
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
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QRCode Buku",
                        style: mTitleStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
