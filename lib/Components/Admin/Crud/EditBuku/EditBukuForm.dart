import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:perpus/Components/custom_surfix_icon.dart';
import 'package:perpus/Screens/Admin/AdminHomeScreen.dart';
import 'package:perpus/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/api/apiConfig.dart';
import 'package:perpus/size_config.dart';
import 'package:perpus/Components/default_button_custom_color.dart';

class EditBukuform extends StatefulWidget {
  @override
  _EditBukuform createState() => _EditBukuform();
}

class _EditBukuform extends State<EditBukuform> {
  TextEditingController txtJudulBuku = TextEditingController(
          text: '${EditBukuScreens.dataBuku['judulBuku']}'),
      txtPenulisBuku = TextEditingController(
          text: '${EditBukuScreens.dataBuku['penulisBuku']}'),
      txtPenerbit = TextEditingController(
          text: '${EditBukuScreens.dataBuku['penerbit']}'),
      txtTahunTerbit = TextEditingController(
          text: '${EditBukuScreens.dataBuku['tahunTerbit']}');

  FocusNode focusNode = new FocusNode();
  File? image;

  Response? response; //connecting with api
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildJudulBuku(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPenulis(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPenerbit(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTahunTerbit(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "SUBMIT",
            press: () {
              if (txtJudulBuku.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.SCALE,
                        title: 'Gagal!',
                        desc: 'Judul Buku tidak boleh kosong!',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtPenulisBuku.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.SCALE,
                        title: 'Gagal!',
                        desc: 'Penulis buku tidak boleh kosong!',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtPenerbit.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.SCALE,
                        title: 'Gagal!',
                        desc: 'Penerbit buku tidak boleh kosong!',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtTahunTerbit.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.SCALE,
                        title: 'Gagal!',
                        desc: 'tahun terbit buku tidak boleh kosong!',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataBuku(txtJudulBuku.text, txtPenulisBuku.text,
                    txtPenerbit.text, txtTahunTerbit.text);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildJudulBuku() {
    return TextFormField(
      controller: txtJudulBuku,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Judul Buku',
        hintText: 'Masukkan Judul Buku',
        labelStyle: TextStyle(
            color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPenulis() {
    return TextFormField(
      controller: txtPenulisBuku,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Penulis',
        hintText: 'Masukkan Nama Penulis',
        labelStyle: TextStyle(
            color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPenerbit() {
    return TextFormField(
      controller: txtPenerbit,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Penerbit',
        hintText: 'Masukkan Nama Penerbit',
        labelStyle: TextStyle(
            color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildTahunTerbit() {
    return TextFormField(
      controller: txtTahunTerbit,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Tahun Terbit',
          hintText: 'Masukkan Masukan Tahun Terbit',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  void editDataBuku(judul, penulis, penerbit, tahun) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response =
          await dio.put('$editBuku/${EditBukuScreens.dataBuku['_id']}', data: {
        'judulBuku': judul,
        'penulisBuku': penulis,
        'penerbit': penerbit,
        'tahunTerbit': tahun,
      });
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Berhasil!',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, AdminHomeScreen.routeName);
            }).show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Gagal',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, AdminHomeScreen.routeName);
            }).show();
      }
    } catch (e) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Gagal',
          desc: 'Terjadi kesalahan internal',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, AdminHomeScreen.routeName);
          }).show();
    }
  }
}
