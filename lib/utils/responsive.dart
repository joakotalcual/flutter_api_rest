import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive{

  // Atributos de la clase Responsive
  double _width = 0;
  double _height = 0;
  double _diagonal = 0;
  bool _isTablet = false;

  // Constructor de la clase Responsive
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    _isTablet = size.shortestSide >= 600;
  }

  // Método estático para obtener una instancia de Responsive
  static Responsive of(BuildContext context) => Responsive(context);

  // Getters para obtener las propiedades del dispositivo
  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  // Métodos para calcular el tamaño en porcentaje
  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;

}
