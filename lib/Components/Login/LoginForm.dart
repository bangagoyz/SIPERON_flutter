// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:perpus/Components/custom_surfix_icon.dart';
import 'package:perpus/Components/default_button_custom_color.dart';
import 'package:perpus/Screens/Register/RegisterScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

class SignInform extends StatefulWidget {
  @override
  _SignInForm createState() => _SignInForm();
}

class _SignInForm extends State<SignInform> {
  // ignore: unnecessary_new
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;

  TextEditingController txtUserName =
          TextEditingController(), //penampungan text
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
        //placement set
        child: Column(
      children: [
        buildUserName(),
        SizedBox(height: getProportionateScreenHeight(30)), //jarak bawah
        buildPassword(),
        SizedBox(height: getProportionateScreenHeight(30)),
        Row(
          children: [
            Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                }),
            Text("Tetap Masuk"),
            Spacer(), //jarak kanan kiri
            GestureDetector(
              onTap: () {},
              child: Text(
                "Lupa Password",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ) //
          ],
        ),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "MASUK",
          press: () {},
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegisterScreen.routeName);
          },
          child: Text(
            "Belum punya akun? daftar disini",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    ));
  }

  //create input textbox

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Masukan username anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true, //stars on text
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukan password anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }
}
