// Clase que representa la respuesta de autenticación
class AuthenticationResponse {
  // Token de acceso
  final String token;
  // Tiempo de expiración del token en segundos
  final int expiresIn;

  // Constructor de la clase
  AuthenticationResponse({
    required this.token,
    required this.expiresIn,
  });

  // Método estático para crear una instancia de AuthenticationResponse a partir de un mapa JSON
  static AuthenticationResponse fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
        // Asignar el valor del token desde el mapa JSON
        token: json['token'],
        // Asignar el valor de expiresIn desde el mapa JSON
        expiresIn: json['expiresIn'],
    );
  }

}
