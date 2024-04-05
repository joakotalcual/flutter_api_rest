// Importaciones necesarias para el proyecto Flutter
import 'package:flutter/material.dart'; // Importa definiciones específicas de Material Design para widgets y temas
import 'package:flutter/services.dart'; // Importa definiciones específicas del sistema para servicios y canales de plataforma
import 'package:flutter_api_rest/helpers/dependency_injection.dart'; // Importa la clase de inyección de dependencias
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa la página principal de la aplicación
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa la página de inicio de sesión de la aplicación
import 'package:flutter_api_rest/pages/register_page.dart'; // Importa la página de registro de la aplicación
import 'package:flutter_api_rest/pages/splash_page.dart'; // Importa la página de inicio de la aplicación

// Función principal de inicio del programa Flutter
void main() {
  // Inicialización de la inyección de dependencias
  DependencyInjection.initialize();
  // Ejecución de la aplicación Flutter
  runApp(const MyApp());
}

// Clase principal de la aplicación Flutter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración de las orientaciones preferidas de la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    // Devuelve un MaterialApp que contiene la estructura de la aplicación
    return MaterialApp(
      // Desactiva el banner de depuración
      debugShowCheckedModeBanner: false,
      // Tema de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Define el esquema de color de la aplicación
        useMaterial3: true, // Activa el uso de Material 3
      ),
      // Página inicial de la aplicación
      home: const SplashPage(),
      // Rutas de la aplicación
      routes: {
        RegisterPage.routeName : (_) => const RegisterPage(), // Ruta para la página de registro
        LoginPage.routeName : (_) => const LoginPage(), // Ruta para la página de inicio de sesión
        HomePage.routeName : (_) => const HomePage(), // Ruta para la página principal
      },
    );
  }
}
