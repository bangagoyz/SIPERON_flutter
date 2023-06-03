import 'package:flutter/material.dart';
import 'package:perpus/Components/Register/RegisterForm.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

class Registercomponent extends StatefulWidget {
  @override
  _RegisterComponent createState() => _RegisterComponent();
}

class _RegisterComponent extends State<Registercomponent> {
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
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Registrasi",
                          style: mTitleStyleNameApps,
                        )
                      ]),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                SignUpform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
