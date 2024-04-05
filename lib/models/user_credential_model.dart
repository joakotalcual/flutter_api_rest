// Clase que representa las credenciales de un usuario
class UserCredentialModel {
  // Correo electrónico del usuario
  final String _email;
  // Contraseña del usuario
  final String _password;

  // Constructor de la clase
  UserCredentialModel({
    required String email, // Correo electrónico proporcionado al crear una instancia de la clase
    required String password // Contraseña proporcionada al crear una instancia de la clase
  }) : _password = password, // Asigna el valor de la contraseña al atributo privado _password
        _email = email; // Asigna el valor del correo electrónico al atributo privado _email

  // Método para obtener el correo electrónico del usuario
  String get email => _email;

  // Método para obtener la contraseña del usuario
  String get password => _password;
}
