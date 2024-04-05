// Importaciones de Dart y paquetes externos
import 'dart:async'; // Importación de la biblioteca dart:async para manejar operaciones asíncronas
import 'dart:convert'; // Importación de la biblioteca dart:convert para codificar y decodificar objetos JSON

import 'package:flutter_api_rest/api/authentication_api.dart'; // Importación de la clase AuthenticationApi del paquete api
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importación de la clase AuthenticationResponse del paquete models
import 'package:flutter_api_rest/models/session.dart'; // Importación de la clase Session del paquete models
import 'package:flutter_api_rest/utils/logs.dart'; // Importación de la clase Logs del paquete utils
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importación de la clase FlutterSecureStorage del paquete flutter_secure_storage

// Clase que representa un cliente de autenticación
class AuthenticationClient {
  final FlutterSecureStorage _secureStorage; // Almacén seguro para guardar la sesión
  final AuthenticationApi _authenticationApi; // API de autenticación

  Completer? _completer; // Completer para manejar operaciones asíncronas

  // Constructor de la clase AuthenticationClient
  AuthenticationClient(this._secureStorage, this._authenticationApi);

  // Método para completar operaciones pendientes
  void complete() {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete();
    }
  }

  // Método para obtener el token de acceso
  Future<String?> get accessToken async {
    if (_completer != null) {
      await _completer!.future;
    }

    Logs.p.i('Llamada ${DateTime.now()}');

    _completer = Completer();

    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createAt;
      final int expiresIn = session.expiresIn;
      final int diff = currentDate.difference(createdAt).inSeconds;
      Logs.p.i('session life time ${expiresIn - diff}');
      if ((expiresIn - diff) >= 60) {
        complete();
        return session.token;
      }
      final response = await _authenticationApi.refreshToken(session.token);
      if (response.data != null) {
        await saveSession(response.data!);
        complete();
        return response.data!.token;
      }
      complete();
      return null;
    }
    complete();
    return null;
  }

  // Método para guardar la sesión
  Future<void> saveSession(AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createAt: DateTime.now(),
    );
    final data = jsonEncode(session.toJson());
    await _secureStorage.write(
      key: 'SESSION',
      value: data,
    );
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}
