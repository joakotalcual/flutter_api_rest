// Importaciones de modelos
import 'package:flutter_api_rest/models/user_credential_model.dart'; // Importación de la clase UserCredentialModel del paquete models
import 'package:flutter_api_rest/models/user_register_model.dart'; // Importación de la clase UserRegisterModel del paquete models

// Importaciones de ayudantes
import 'package:flutter_api_rest/helpers/http.dart'; // Importación de la clase Http del paquete helpers
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importación de la clase HttpResponse del paquete helpers

// Importaciones de modelos de respuesta
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importación de la clase AuthenticationResponse del paquete models

// Clase que representa la API de autenticación
class AuthenticationApi {
  final Http _http; // Cliente HTTP para realizar peticiones

  // Constructor de la clase AuthenticationApi
  AuthenticationApi(this._http);

  // Método para registrar un usuario
  Future<HttpResponse<AuthenticationResponse>> register({
    required UserRegisterModel userRegister,
  }) {
    return _http.request<AuthenticationResponse>(
      '/register',
      method: 'POST',
      data: {
        "username": userRegister.username,
        "email": userRegister.email,
        "password": userRegister.password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  // Método para iniciar sesión
  Future<HttpResponse<AuthenticationResponse>> login({
    required UserCredentialModel userCredential,
  }) async {
    return _http.request<AuthenticationResponse>(
      '/login',
      method: 'POST',
      data: {
        "email": userCredential.email,
        "password": userCredential.password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  // Método para refrescar el token de autenticación
  Future<HttpResponse<AuthenticationResponse>> refreshToken(String expiredToken) {
    return _http.request<AuthenticationResponse>(
      '/refresh-token',
      method: 'POST',
      headers: {
        'token': expiredToken,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }
}
