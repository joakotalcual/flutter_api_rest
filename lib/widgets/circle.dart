import 'package:flutter/material.dart';

class Circle extends StatelessWidget {

  // Atributos de la clase Circle
  final double size;
  final List<Color> colors;

  // Constructor de la clase Circle
  const Circle({
    super.key,
    required this.size,
    required this.colors
  }): assert (size > 0),
        assert (colors.length >= 2);

  @override
  Widget build(BuildContext context) {
    // Devuelve un contenedor con forma de círculo y un degradado lineal
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
    );
  }
}
