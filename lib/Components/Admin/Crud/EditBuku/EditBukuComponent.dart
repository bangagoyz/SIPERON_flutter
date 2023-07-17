import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/Crud/EditBuku/editBukuForm.dart';
import 'package:perpus/Components/Admin/Crud/InputBuku/InputBukuForm.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:perpus/Components/Login/LoginForm.dart';

class EditBukuComponent extends StatefulWidget {
  @override
  _EditBukuComponent createState() => _EditBukuComponent();
}

class _EditBukuComponent extends State<EditBukuComponent> {
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
                        "Edit Data Buku",
                        style: mTitleStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                EditBukuform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
