import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Column(
        children: <Widget>[
          InputText(
            keyboardType: TextInputType.emailAddress,
            label: "EMAIL ADDRESS",
            fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
          ),
          SizedBox(height: responsive.dp(2)),
          Container(
            constraints: BoxConstraints(
              maxWidth: responsive.isTablet ? 430 : 360,
            ),
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
                  ),
                ),
                //Ya quedo obsoleto el flatButton
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
              child: Text(
                "Sign in",
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () {},
              color: Colors.pinkAccent,
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
              onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: responsive.dp(10)),
        ],
      ),
    );
  }
}