import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final Logger _logger = Logger();

  Future<void> _submit() async {
    final isOk = _formKey.currentState?.validate();
    if(isOk != null && isOk){
      ProgressDialog.show(context);
      final response = await _authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password
      );
      ProgressDialog.dissmiss(context);
      if(response.data!=null){
        _logger.i("register OK");
      }else{
        _logger.e("register error statusCode ${response.error.statusCode}");
        _logger.e("register error message ${response.error.message}");
        _logger.e("register error data ${response.error.data}");
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
                child: Text(
                  "Sign up",
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Colors.pinkAccent,
                onPressed: (){
                  _submit();
                },
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