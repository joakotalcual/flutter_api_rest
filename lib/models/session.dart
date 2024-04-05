// Clase que representa una sesión de autenticación
class Session {
  // Token de acceso
  final String token;
  // Tiempo de expiración del token en segundos
  final int expiresIn;
  // Fecha y hora de creación de la sesión
  final DateTime createAt;

  // Constructor de la clase
  Session({
    required this.token,
    required this.expiresIn,
    required this.createAt,
  });

  // Método estático para crear una instancia de Session a partir de un mapa JSON
  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      // Asignar el valor del token desde el mapa JSON
      token: json['token'],
      // Asignar el valor de expiresIn desde el mapa JSON
      expiresIn: json['expiresIn'],
      // Convertir la cadena de fecha y hora en un objeto DateTime
      createAt: DateTime.parse(json['createAt']),
    );
  }

  // Método para convertir la instancia de Session a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      // Asignar el valor del token al mapa JSON
      'token' : token,
      // Asignar el valor de expiresIn al mapa JSON
      'expiresIn' : expiresIn,
      // Convertir la fecha y hora a una cadena ISO 8601 y asignarla al mapa JSON
      'createAt' : createAt.toIso8601String(),
    };
  }
}
