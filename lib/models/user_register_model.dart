// Clase que representa los datos de registro de un usuario
class UserRegisterModel {
  // Nombre de usuario del usuario
  final String _username;
  // Correo electrónico del usuario
  final String _email;
  // Contraseña del usuario
  final String _password;

  // Constructor de la clase
  UserRegisterModel({
    required String username, // Nombre de usuario proporcionado al crear una instancia de la clase
    required String email, // Correo electrónico proporcionado al crear una instancia de la clase
    required String password // Contraseña proporcionada al crear una instancia de la clase
  }) : _password = password, // Asigna el valor de la contraseña al atributo privado _password
        _email = email, // Asigna el valor del correo electrónico al atributo privado _email
        _username = username; // Asigna el valor del nombre de usuario al atributo privado _username

  // Método para obtener el nombre de usuario del usuario
  String get username => _username;

  // Método para obtener el correo electrónico del usuario
  String get email => _email;

  // Método para obtener la contraseña del usuario
  String get password => _password;
}
