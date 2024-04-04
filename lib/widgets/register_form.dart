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

  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  Future<void>_submit() async {
    final bool isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationApi.register(
          userRegister: UserRegisterModel(
              username: _username,
              email: _email,
              password: _password
          ),
      );
      ProgressDialog.dismiss(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      }
      else {

        String message = response.error!.message;

        if (response.error!.statusCode == -1) {
          message = 'Bad Network';
        }
        else if (response.error!.statusCode == 409) {
          message = 'Duplicate user ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }

        Dialogs.alert(
            context,
            title: 'Error',
            description: message
        );
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
              label: "USERNAME",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _username = text;
              },
              validator: (text){
                if(text!.trim().length < 5){
                  return "Invalid username";
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)),
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
            InputText(
              obscureText: true,//Hace que no este visible como en el input text normal
              label: "PASSWORD",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
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
            SizedBox(height: responsive.dp(8)),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: Colors.pinkAccent,
                onPressed: (){
                  _submit();
                },
                child: const Text(
                  "Sign up",
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