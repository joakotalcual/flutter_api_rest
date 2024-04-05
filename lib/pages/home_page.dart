import 'dart:typed_data'; // Importación de la librería 'dart:typed_data' para manejar datos binarios.

import 'package:flutter/material.dart'; // Importación de la librería 'package:flutter/material' para utilizar widgets de Material Design.
import 'package:flutter_api_rest/api/account_api.dart'; // Importación de 'account_api.dart' para manejar la API de la cuenta.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importación de 'authentication_client.dart' para manejar la autenticación del cliente.
import 'package:flutter_api_rest/models/User.dart'; // Importación del modelo 'User' para representar los datos del usuario.
import 'package:flutter_api_rest/pages/login_page.dart'; // Importación de 'login_page.dart' para la página de inicio de sesión.
import 'package:flutter_api_rest/utils/logs.dart'; // Importación de 'logs.dart' para manejar los registros.
import 'package:get_it/get_it.dart'; // Importación de 'get_it.dart' para la obtención de instancias singleton.
import 'package:image_picker/image_picker.dart'; // Importación de 'image_picker.dart' para seleccionar imágenes.
import 'package:path/path.dart' as path; // Importación de 'path.dart' como 'path' para manipular rutas de archivos.

class HomePage extends StatefulWidget { // Definición de la clase 'HomePage' como un StatefulWidget.
  static String routeName = 'home'; // Definición del nombre de la ruta estática 'routeName'.

  const HomePage({super.key}); // Constructor de la clase 'HomePage'.

  @override
  State<HomePage> createState() => _HomePageState(); // Creación del estado para la clase 'HomePage'.
}

class _HomePageState extends State<HomePage> { // Definición de la clase '_HomePageState' que extiende de 'State<HomePage>'.
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación.
  final _accountApi = GetIt.instance<AccountApi>(); // Instancia de la API de la cuenta.
  User? _user; // Variable que almacena los datos del usuario.

  @override
  void initState() { // Método que se ejecuta al inicializar el estado del widget.
    super.initState(); // Llamada al método 'initState' de la clase base.
    WidgetsBinding.instance!.addPostFrameCallback((_) { // Se añade un callback para ser llamado después de que el marco esté en su lugar.
      _loadUser(); // Llamada al método para cargar los datos del usuario.
    });
  }

  Future<void> _loadUser() async { // Método asincrónico para cargar los datos del usuario.
    final response = await _accountApi.getUserInfo(); // Se obtienen los datos del usuario desde la API.
    if (response.data != null) { // Si los datos no son nulos.
      Logs.p.i(response.data!.createdAt); // Se registran los datos del usuario.
      _user = response.data!; // Se asignan los datos del usuario a la variable local.
      setState(() {}); // Se actualiza el estado del widget.
    }
  }

  Future<void> _signOut() async { // Método asincrónico para cerrar sesión.
    _authenticationClient.signOut(); // Se llama al método para cerrar sesión del cliente de autenticación.
    Navigator.pushNamedAndRemoveUntil( // Se navega a la página de inicio de sesión y se elimina la ruta actual.
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }

  Future<void> _pickImage() async { // Método asincrónico para seleccionar una imagen.
    final ImagePicker imagePicker = ImagePicker(); // Instancia del selector de imágenes.
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera); // Se selecciona una imagen desde la cámara.
    if (pickedFile != null) { // Si se selecciona un archivo.
      final Uint8List bytes = await pickedFile.readAsBytes(); // Se leen los bytes de la imagen.
      final filename = path.basename(pickedFile.path); // Se obtiene el nombre del archivo.
      final response = await _accountApi.updateAvatar(bytes, filename); // Se actualiza el avatar del usuario.
      if (response != null) { // Si la respuesta no es nula.
        _user = _user!.copyWith(avatar: response.data); // Se actualiza el avatar del usuario en la variable local.
        final String imageUrl = 'http://192.168.1.14:9000${response.data}'; // Se construye la URL de la imagen.
        Logs.p.i(imageUrl); // Se registran los datos de la URL de la imagen.
        setState(() {}); // Se actualiza el estado del widget.
      }
    }
  }

  @override
  Widget build(BuildContext context) { // Método que construye la interfaz de usuario.
    return Scaffold( // Estructura base de la pantalla.
      body: Container( // Contenedor principal.
        width: double.infinity, // Ancho máximo disponible.
        child: Column( // Columna que organiza los elementos verticalmente.
          mainAxisAlignment: MainAxisAlignment.center, // Alineación principal al centro.
          children: [ // Lista de widgets hijos.
            if (_user == null) const CircularProgressIndicator(), // Si no hay usuario, se muestra un indicador de progreso.
            if (_user != null) // Si hay usuario:
              Column( // Columna que contiene los datos del usuario.
                children: [
                  if (_user!.avatar != null) // Si el usuario tiene avatar:
                    ClipOval( // Recortar la imagen en forma de círculo.
                      child: Image.network( // Widget de imagen desde una URL.
                        'http://192.168.1.14:9000${_user!.avatar}', // URL del avatar del usuario.
                        width: 100, // Ancho de la imagen.
                        height: 100, // Altura de la imagen.
                        fit: BoxFit.cover, // Ajuste de la imagen al contenedor.
                      ),
                    ),
                  Text(_user!.id), // Widget de texto con el ID del usuario.
                  Text(_user!.email), // Widget de texto con el correo electrónico del usuario.
                  Text(_user!.username), // Widget de texto con el nombre de usuario.
                  Text(_user!.createdAt.toIso8601String()) // Widget de texto con la fecha de creación del usuario.
                ],
              ),
            const SizedBox(height: 30,), // Espacio vertical entre los botones.
            ElevatedButton( // Botón elevado para actualizar el avatar.
              onPressed: _pickImage, // Acción al presionar el botón.
              child: const Text('Update avatar'), // Texto del botón.
            ),
            ElevatedButton( // Botón elevado para cerrar sesión.
              onPressed: _signOut, // Acción al presionar el botón.
              child: const Text('Sign Out'), // Texto del botón.
            ),
          ],
        ),
      ),
    );
  }
}
