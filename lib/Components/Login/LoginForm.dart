// ignore_for_file: library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perpus/Components/custom_surfix_icon.dart';
import 'package:perpus/Components/default_button_custom_color.dart';
import 'package:perpus/Screens/Register/RegisterScreen.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';

import '../../Screens/Admin/AdminHomeScreen.dart';

class SignInform extends StatefulWidget {
  @override
  _SignInForm createState() => _SignInForm();
}

class _SignInForm extends State<SignInform> {
  DateTime timeBackPressed = DateTime.now();
  // ignore: unnecessary_new
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;

  TextEditingController txtUserName =
          TextEditingController(), //penampungan text
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final message = 'Tekan lagi untuk keluar';
            Fluttertoast.showToast(msg: message, fontSize: 18);
            SystemNavigator.pop();
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Form(
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
              press: () {
                loginProcess(txtUserName.text, txtPassword.text);
              },
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
        )));
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

  void loginProcess(userName, passwd) async {
    utilsApps.showDialog(context); //pop up message dialog

    bool status;
    var msg;
    var userData;
    try {
      response = await dio.post(loginUrl, data: {
        'username': userName,
        'password': passwd,
      });

      status = response!.data['sukses']; //data dari notif api
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'SUKSES',
            desc: 'Berhasil Login',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              userData = response!.data['data'];
              if (userData['role'] == 1) {
                Navigator.pushNamed(context, UserHomeScreen.routeName,
                    arguments: userData);
                utilsApps.hideDialog(context);
              } else if (userData['role'] == 2) {
                Navigator.pushNamed(context, AdminHomeScreen.routeName);
                utilsApps.hideDialog(context);
              } else {
                print("halaman tidak jelas");
              }
            }).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'GAGAL',
          desc: 'Gagal Login => $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
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
