import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

class LoginPage extends StatefulWidget {

  // Definir la ruta de navegación para la página de inicio de sesión
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // Obtener la información de la pantalla para hacerla sensible
    final Responsive responsive = Responsive.of(context);
    // Definir el tamaño de los círculos de fondo
    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);

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
                  right: -pinkSize * 0.2,
                  top: -pinkSize * 0.4,
                  child: Circle(
                    size: pinkSize,
                    colors: const [
                      Colors.pink,
                      Colors.pinkAccent
                    ],
                  ),
                ),
                // Posicionar un círculo naranja en la parte superior izquierda
                Positioned(
                  left: -orangeSize * 0.15,
                  top: -orangeSize * 0.55,
                  child: Circle(
                    size: orangeSize,
                    colors: const [
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ],
                  ),
                ),
                // Posicionar el ícono y el texto "Hello Again Welcome Back" en el centro
                Positioned(
                  top: pinkSize * 0.4,
                  child: Column(
                    children: [
                      IconContainer(
                        size: responsive.wp(17),
                      ),
                      SizedBox(
                        height: responsive.dp(3),
                      ),
                      Text(
                        "Hello Again\nWelcome Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.7)
                        ),
                      ),
                    ],
                  ),
                ),
                // Colocar el formulario de inicio de sesión en la pila
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
