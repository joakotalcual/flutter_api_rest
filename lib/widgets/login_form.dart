// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/user_credential_model.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Clave global para el formulario
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Instancias de clases necesarias
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  // Variables para almacenar los datos del usuario
  String _email = '', _password = '';

  // Método para enviar los datos del formulario
  Future<void> _submit() async {
    // Validar el formulario
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      // Mostrar un diálogo de progreso
      ProgressDialog.show(context);
      // Enviar la solicitud de inicio de sesión al servidor
      final response = await _authenticationApi.login(
          userCredential:
              UserCredentialModel(email: _email, password: _password));
      // Ocultar el diálogo de progreso
      ProgressDialog.dismiss(context);
      // Verificar si la respuesta es exitosa
      if (response.data != null) {
        // Guardar la sesión del usuario
        await _authenticationClient.saveSession(response.data!);
        // Navegar a la página de inicio y eliminar todas las rutas anteriores
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        // Manejar errores de la respuesta
        String message = response.error!.message;
        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        } else if (response.error!.statusCode == 403) {
          message = 'Invalid password';
        } else if (response.error!.statusCode == 404) {
          message = 'User not found';
        }
        // Mostrar un diálogo de alerta con el mensaje de error
        Dialogs.alert(context, title: 'Error', description: message);
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
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        obscureText: true,
                        label: "PASSWORD",
                        borderEnabled: false,
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
                    ),
                    // Botón para restablecer la contraseña (simulado)
                    TextButton(
                      onPressed: () {}, // Sin realizar ninguna acción
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(4)),
              // Botón para enviar el formulario
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: Colors.pinkAccent,
                  onPressed: (){
                    _submit();
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              // Texto y botón para registrarse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("New to Friendly Desi?", style: TextStyle(fontSize: responsive.dp(1.5)),),
                  MaterialButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
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
