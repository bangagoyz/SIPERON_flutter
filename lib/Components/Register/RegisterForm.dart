import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/custom_surfix_icon.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';
import 'package:perpus/Components/default_button_custom_color.dart';

class SignUpform extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>();
  String? namaLengkap;
  String? username;
  String? email;
  String? password;

  TextEditingController txtNamaLengkap = TextEditingController(),
      txtUsername = TextEditingController(),
      txtEmail = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response; //connecting with api
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaLengkap(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUsername(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Daftar Akun",
            press: () {
              // print(txtNamaLengkap.text);
              // print(txtUsername.text);
              // print(txtPassword.text);
              // print(txtEmail.text);
              registrationProcess(txtUsername.text, txtPassword.text,
                  txtNamaLengkap.text, txtEmail.text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              "Sudah punya akun? Masuk disini",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: txtNamaLengkap,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Lengkap',
          hintText: 'Masukkan nama lengkap anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildUsername() {
    return TextFormField(
      controller: txtUsername,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Masukkan Username anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Masukkan Email anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukkan Password anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  void registrationProcess(userName, passwd, nama, email) async {
    utilsApps.showDialog(context); //pop up message dialog

    bool status;
    var msg;
    try {
      response = await dio.post(registerUrl, data: {
        'username': userName,
        'password': passwd,
        'nama': nama,
        'email': email
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'SUKSES',
          desc: 'Berhasil Registrasi',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'GAGAL',
          desc: 'Gagal Registrasi => $msg',
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
