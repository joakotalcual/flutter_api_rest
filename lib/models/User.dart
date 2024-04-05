// Clase que representa un usuario
class User {
  // Identificador del usuario
  final String id;
  // Nombre de usuario del usuario
  final String username;
  // Correo electrónico del usuario
  final String email;
  // Fecha y hora de creación del usuario
  final DateTime createdAt;
  // Fecha y hora de la última actualización del usuario
  final DateTime updatedAt;
  // URL del avatar del usuario
  final String avatar;

  // Constructor de la clase User
  User({
    required this.id, // Identificador del usuario
    required this.username, // Nombre de usuario del usuario
    required this.email, // Correo electrónico del usuario
    required this.createdAt, // Fecha y hora de creación del usuario
    required this.updatedAt, // Fecha y hora de la última actualización del usuario
    required this.avatar, // URL del avatar del usuario
  });

  // Método de fábrica para crear una instancia de User a partir de un objeto JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"], // Identificador del usuario
    username: json["username"], // Nombre de usuario del usuario
    email: json["email"], // Correo electrónico del usuario
    createdAt: DateTime.parse(json["createdAt"]), // Fecha y hora de creación del usuario
    updatedAt: DateTime.parse(json["updatedAt"]), // Fecha y hora de la última actualización del usuario
    avatar: json['avatar'], // URL del avatar del usuario
  );

  // Método para convertir un objeto User a un objeto JSON
  Map<String, dynamic> toJson() => {
    "_id": id, // Identificador del usuario
    "username": username, // Nombre de usuario del usuario
    "email": email, // Correo electrónico del usuario
    "createdAt": createdAt.toIso8601String(), // Fecha y hora de creación del usuario
    "updatedAt": updatedAt.toIso8601String(), // Fecha y hora de la última actualización del usuario
    'avatar' : avatar, // URL del avatar del usuario
  };

  // Método para crear una copia del objeto User con algunos campos opcionales actualizados
  User copyWith({
    String? id, // Nuevo identificador del usuario (opcional)
    String? username, // Nuevo nombre de usuario del usuario (opcional)
    String? email, // Nuevo correo electrónico del usuario (opcional)
    DateTime? createdAt, // Nueva fecha y hora de creación del usuario (opcional)
    DateTime? updatedAt, // Nueva fecha y hora de la última actualización del usuario (opcional)
    String? avatar, // Nueva URL del avatar del usuario (opcional)
  }) =>
      User(
        id: id ?? this.id, // Nuevo identificador del usuario o el mismo si no se proporciona uno nuevo
        username: username ?? this.username, // Nuevo nombre de usuario del usuario o el mismo si no se proporciona uno nuevo
        email: email ?? this.email, // Nuevo correo electrónico del usuario o el mismo si no se proporciona uno nuevo
        createdAt: createdAt ?? this.createdAt, // Nueva fecha y hora de creación del usuario o la misma si no se proporciona una nueva
        updatedAt: updatedAt ?? this.updatedAt, // Nueva fecha y hora de la última actualización del usuario o la misma si no se proporciona una nueva
        avatar: avatar ?? this.avatar // Nueva URL del avatar del usuario o la misma si no se proporciona una nueva
      );
}
