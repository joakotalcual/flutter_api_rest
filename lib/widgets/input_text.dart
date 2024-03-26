import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  const InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}