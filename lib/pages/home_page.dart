// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

class HomePage extends  StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              top: -(pinkSize)*0.35,
              right: -(pinkSize)*0.2,
              child: Circle(
                size: pinkSize,
                colors: const [Colors.pinkAccent, Colors.pink],
              ),
            ),
            Positioned(
              top: -(orangeSize)*0.65,
              left: -(orangeSize)*0.15,
              child: Circle(
                size: orangeSize,
                colors: const [Colors.orange, Colors.deepOrange],
              ),
            ),
            Positioned(
              top: pinkSize * 0.4,
              child: Column(
                children: [
                  IconContainer(
                    size: logoSize,
                  ),
                  SizedBox(
                    height: responsive.dp(3),
                  ),
                  Text(
                    "Hello Again\nWelcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: responsive.dp(2),
                    ),
                  ),
                ],
              ),
            ),
            LoginForm()
          ],
        ),
      ),
      ),
      ),
    );
  }
}