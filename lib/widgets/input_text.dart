import 'package:flutter/material.dart';

class InputText extends StatelessWidget {

  // Atributos de la clase InputText
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;

  // Constructor de la clase InputText
  const InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    // Definición de un borde inferior para el campo de entrada
    const UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    );
    // Devuelve un campo de entrada de texto con formato
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(fontSize: fontSize),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        enabledBorder: borderEnabled ? underlineInputBorder : InputBorder.none,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
