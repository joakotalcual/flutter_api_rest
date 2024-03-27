// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/avatar_button.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/register_form.dart';

class RegisterPage extends  StatefulWidget{
  static const routeName = 'register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(75);
    final double orangeSize = responsive.wp(65);
    final double logoSize = responsive.wp(20);

    return Scaffold(
      body: GestureDetector(
        //Minimar el teclado si presiona en otro lado del textForm
        onTap: (){
          FocusScope.of(context).unfocus();
        },
      child: SingleChildScrollView(
        child:Container(
        width: double.infinity,
        height: responsive.height,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -(pinkSize)*0.15,
              right: -(pinkSize)*0.2,
              child: Circle(
                size: pinkSize,
                colors: const [Colors.pinkAccent, Colors.pink],
              ),
            ),
            Positioned(
              top: -(orangeSize)*0.45,
              left: -(orangeSize)*0.15,
              child: Circle(
                size: orangeSize,
                colors: const [Colors.orange, Colors.deepOrange],
              ),
            ),
            Positioned(
              top: pinkSize * 0.2,
              child: Column(
                children: [
                  Text(
                    "Hello!\nSign up to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: responsive.dp(2),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: responsive.dp(4.5),),
                  AvatarButton(
                    imageSize: responsive.wp(25),
                  ),
                ],
              ),
            ),
            RegisterForm(),
            Positioned(
              left: 15,
              top: 25,
              child: CupertinoButton(
                color: Colors.black26,
                padding: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(30),
                child: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }
}