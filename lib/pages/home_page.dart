// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';

class HomePage extends  StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(75);
    final double orangeSize = responsive.wp(67);
    final double logoSize = responsive.wp(25);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -(pinkSize)*0.3,
              right: -(pinkSize)*0.2,
              child: Circle(
                size: pinkSize,
                colors: const [Colors.pinkAccent, Colors.pink],
              ),
            ),
            Positioned(
              top: -(orangeSize)*0.35,
              left: -(orangeSize)*0.15,
              child: Circle(
                size: orangeSize,
                colors: const [Colors.orange, Colors.deepOrange],
              ),
            ),
            Positioned(
              top: pinkSize * 0.45,
              child: Column(
                children: [
                  IconContainer(
                    size: logoSize,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Hello Again\nWelcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}