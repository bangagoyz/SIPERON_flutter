import 'package:flutter/material.dart';
import 'package:perpus/size_config.dart';
import 'package:perpus/Components/Register/RegisterComponent.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //mengghilangkan tombol back
      ),
      body: Registercomponent(),
    );
  }
}
