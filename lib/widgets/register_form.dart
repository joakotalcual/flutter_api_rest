import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/user_register_model.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Clave global para el formulario
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Variables para almacenar los datos del usuario
  String _email = '', _password = '', _username = '';
  // Instancias de clases necesarias
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  // Método para enviar los datos del formulario
  Future<void> _submit() async {
    // Validar el formulario
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      // Mostrar un diálogo de progreso
      ProgressDialog.show(context);
      // Enviar la solicitud de registro al servidor
      final response = await _authenticationApi.register(
        userRegister: UserRegisterModel(
          username: _username,
          email: _email,
          password: _password,
        ),
      );
      // Ocultar el diálogo de progreso
      ProgressDialog.dismiss(context);
      // Verificar si la respuesta es exitosa
      if (response.data != null) {
        // Guardar la sesión del usuario
        await _authenticationClient.saveSession(response.data!);
        // Navegar a la página de inicio y eliminar todas las rutas anteriores
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      } else {
        // Manejar errores de la respuesta
        String message = response.error!.message;
        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        } else if (response.error!.statusCode == 409) {
          message = 'Duplicate user ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }
        // Mostrar un diálogo de alerta con el mensaje de error
        Dialogs.alert(
          context,
          title: 'Error',
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el objeto responsive para adaptar el diseño a diferentes pantallas
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Campo de entrada para el nombre de usuario
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text!.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              // Campo de entrada para la dirección de correo electrónico
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (!text!.contains('@')) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              // Campo de entrada para la contraseña
              InputText(
                obscureText: true, // Oculta el texto de la contraseña
                label: "PASSWORD",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text?.trim().isEmpty == true) {
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(8)),
              // Botón para enviar el formulario
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: Colors.pinkAccent,
                  onPressed: () {
                    _submit();
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              // Texto y botón para iniciar sesión
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?", style: TextStyle(fontSize: responsive.dp(1.5)),),
                  MaterialButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}
