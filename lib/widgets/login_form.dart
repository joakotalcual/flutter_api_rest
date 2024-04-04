// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_cliente.dart';
import 'package:flutter_api_rest/models/user_credential_model.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);

      final response = await _authenticationApi.login(
          userCredential:
              UserCredentialModel(email: _email, password: _password));
      ProgressDialog.dismiss(context);

      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        String message = response.error!.message;

        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        } else if (response.error!.statusCode == 403) {
          message = 'Invalid password';
        } else if (response.error!.statusCode == 404) {
          message = 'User not found';
        }

        Dialogs.alert(context, title: 'Error', description: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

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
            InputText(
              keyboardType: TextInputType.emailAddress,
              label: "EMAIL ADDRESS",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _email = text;
              },
              validator: (text){
                if(!text!.contains('@')){
                  return "Invalid email";
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)),
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
                      onChanged: (text){
                        _password = text;
                      },
                      validator: (text){
                        if(text?.trim().isEmpty == true){
                          return "Invalid password";
                        }
                        return null;
                      },
                    ),
                  ),
                  //Ya quedo obsoleto el flatButton, pero hace la misma función
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