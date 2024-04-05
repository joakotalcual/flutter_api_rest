// Importación de bibliotecas
import 'dart:typed_data'; // Importa las definiciones de clases para manejar datos binarios

import 'package:dio/dio.dart'; // Importa el paquete Dio para realizar peticiones HTTP
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa la clase AuthenticationClient del paquete data
import 'package:flutter_api_rest/helpers/http.dart'; // Importa la clase Http del paquete helpers
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importa la clase HttpResponse del paquete helpers
import 'package:flutter_api_rest/models/User.dart'; // Importa la clase User del paquete models

// Clase que representa la API de la cuenta de usuario
class AccountApi {
  final Http _http; // Cliente HTTP para realizar peticiones
  final AuthenticationClient _authenticationClient; // Cliente de autenticación para obtener el token de acceso

  // Constructor de la clase AccountApi
  AccountApi(this._http, this._authenticationClient);

  // Método para obtener la información del usuario
  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del cliente de autenticación
    return _http.request<User>( // Realiza una petición HTTP para obtener la información del usuario
      '/user-info',
      method: 'GET',
      headers: {
        'token' : token // Añade el token de acceso en los encabezados de la petición
      },
      parser: (data) {
        return User.fromJson(data); // Parsea los datos de la respuesta a un objeto de tipo User
      }
    );
  }

  // Método para actualizar el avatar del usuario
  Future<HttpResponse<String>> updateAvatar(Uint8List bytes, String filename) async {
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del cliente de autenticación
    return _http.request<String>( // Realiza una petición HTTP para actualizar el avatar del usuario
        '/update-avatar',
        method: 'POST',
        headers: {
          'token' : token // Añade el token de acceso en los encabezados de la petición
        },
      formData: {
        'attachment' : MultipartFile.fromBytes(bytes, filename: filename), // Adjunta el archivo de imagen en la petición
      },
    );
  }
}
