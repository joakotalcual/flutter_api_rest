// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';

class HomePage extends  StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final double pinkSize = size.width * 0.75;
    final double orangeSize = size.width * 0.67;

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
              top: -(orangeSize)*0.4,
              left: -(orangeSize)*0.15,
              child: Circle(
                size: orangeSize,
                colors: const [Colors.orange, Colors.deepOrange],
              ),
            ),
            const Positioned(
              top: 130,
              child: IconContainer(
                size: 120,
              ),
            )
          ],
        ),
      ),
    );
  }
}