import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/avatar_button.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  // Definir la ruta de navegación para la página de registro
  static const String routeName = 'register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    // Obtener la información de la pantalla para hacerla sensible
    final Responsive responsive = Responsive.of(context);
    // Definir el tamaño de los círculos de fondo
    final double pinkSize = responsive.wp(88);
    final double orangeSize = responsive.wp(60);

    return Scaffold(
      // La página utiliza un gesto para desactivar el teclado cuando se toca en cualquier lugar
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Posicionar un círculo rosa en la parte superior derecha
                Positioned(
                  right: -pinkSize * 0.20,
                  top: -pinkSize * 0.32,
                  child: Circle(
                    size: pinkSize,
                    colors: const [Colors.pink, Colors.pinkAccent],
                  ),
                ),
                // Posicionar un círculo naranja en la parte superior izquierda
                Positioned(
                  left: -orangeSize * 0.20,
                  top: -orangeSize * 0.40,
                  child: Circle(
                    size: orangeSize,
                    colors: const [Colors.orange, Colors.deepOrangeAccent],
                  ),
                ),
                // Posicionar el texto "Hello Sign up to get started" y el botón Avatar en el centro
                Positioned(
                  top: pinkSize * 0.20,
                  child: Column(
                    children: [
                      Text(
                        "Hello\nSign up to get started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.7), color: Colors.white),
                      ),
                      SizedBox(
                        height: responsive.dp(4.5),
                      ),
                      AvatarButton(
                        imageSize: responsive.wp(25),
                      )
                    ],
                  ),
                ),
                // Colocar el formulario de registro en la pila
                const RegisterForm(),
                // Botón de retorno en la esquina superior izquierda
                Positioned(
                  left: 15,
                  top: 15,
                  child: SafeArea(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black26,
                      child: const Icon(Icons.arrow_back),
                    ),
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
