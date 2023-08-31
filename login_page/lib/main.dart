import 'dart:html';

import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:http/http.dart' as http;
import 'package:login_page/login_result.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  // List<LoginResult> _logResult = [];
  String email = "";
  String password = "";

  Future<void> loginState(email, password) async {
    var parameter = {
      'email': email,
      'password': password,
    };
    var uri = Uri.http("192.168.7.47", "users", parameter);
    var resp = await http.get(uri);
    var _logResult = loginResultFromJson(resp.body);
    if (_logResult.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('email or password invalid')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('login successful')),
      );
    }
    print(resp.body);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                emailInputField(),
                passwordInputField(),
                SizedBox(
                  height: 10.0,
                ),
                submitButton()
              ],
            ),
          ),
        ));
  }

  Widget emailInputField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email",
          helperText: "input your email",
          icon: Icon(Icons.email)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "this field is required !!!!";
        }
        if (!EmailValidator.validate(value)) {
          return "it is not email format";
        }
        return null;
      },
      onSaved: ((newValue) => email = newValue!),
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "password",
          helperText: "input your password",
          icon: Icon(Icons.lock)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "this field is required !!!!";
        }
        return null;
      },
      onSaved: ((newValue) => password = newValue!),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          loginState(email, password);

          print("$email $password");
        }
      },
      child: Text("Login"),
    );
  }
}
