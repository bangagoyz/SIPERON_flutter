import 'package:flutter/material.dart';
import 'package:perpus/Components/Login/LoginComponent.dart';
import 'package:perpus/size_config.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //mengghilangkan tombol back
      ),
      body: LoginComponent(),
    );
  }
}
