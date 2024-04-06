import 'package:flutter/material.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Instancia del cliente de autenticación
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Mostrar un indicador de carga en el centro de la pantalla
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Agregar un callback para ejecutar después de que se haya construido el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  // Método para verificar si el usuario está autenticado
  Future<void> _checkLogin() async {
    // Obtener el token de acceso del cliente de autenticación
    final token = await _authenticationClient.accessToken;
    // Si no hay token, redirigir a la página de inicio de sesión
    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    // Si hay token, redirigir a la página de inicio
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

}
