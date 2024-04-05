// Importaciones de paquetes y archivos necesarios
import 'package:dio/dio.dart'; // Importa la librería 'dio' para realizar peticiones HTTP
import 'package:flutter_api_rest/api/account_api.dart'; // Importa la clase 'AccountApi' para interactuar con la API de la cuenta
import 'package:flutter_api_rest/api/authentication_api.dart'; // Importa la clase 'AuthenticationApi' para interactuar con la API de autenticación
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa la clase 'AuthenticationClient' para manejar la autenticación del cliente
import 'package:flutter_api_rest/helpers/http.dart'; // Importa la clase 'Http' para realizar operaciones HTTP
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importa la librería 'flutter_secure_storage' para manejar el almacenamiento seguro de datos
import 'package:get_it/get_it.dart'; // Importa la librería 'get_it' para la inyección de dependencias

// Clase abstracta para inicializar la inyección de dependencias
abstract class DependencyInjection {
  // Método para inicializar la inyección de dependencias
  static void initialize() {
    // Configuración de opciones base para las peticiones HTTP
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.14:9000/api/v1', // URL base de la API
      ),
    );
    // Instancia de la clase Http para manejar las operaciones HTTP
    final Http http = Http(
      dio: dio, // Cliente HTTP
      logsEnable: true, // Habilitar registros de HTTP
    );
    // Instancia del almacenamiento seguro
    final _secureStorage = FlutterSecureStorage();

    // Instancia de la clase AuthenticationApi para interactuar con la API de autenticación
    final authenticationApi = AuthenticationApi(http);
    // Instancia del cliente de autenticación para manejar la autenticación del cliente
    final authenticationClient = AuthenticationClient(_secureStorage, authenticationApi);
    // Instancia de la clase AccountApi para interactuar con la API de la cuenta
    final accountApi = AccountApi(http, authenticationClient);

    // Obtiene la instancia de GetIt para registrar las instancias de las clases necesarias
    GetIt getIt = GetIt.instance;
    // Registra la instancia de AuthenticationApi como un singleton
    getIt.registerSingleton<AuthenticationApi>(authenticationApi);
    // Registra la instancia de AuthenticationClient como un singleton
    getIt.registerSingleton<AuthenticationClient>(authenticationClient);
    // Registra la instancia de AccountApi como un singleton
    getIt.registerSingleton<AccountApi>(accountApi);
  }
}
