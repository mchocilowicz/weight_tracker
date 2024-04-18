import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback callback;

  const LoginScreen({super.key,required this.callback});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Pole nie może być puste";
    }

    if (value.length < 5 || value.length > 17) {
      return "Wpisana wartość powinna mieć długość między 5 a 16 znaków";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: _loginForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "E-mail", label: Text("E-mail")),
                  validator: (value) {
                    return _validate(value);
                  },
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: "Hasło", label: Text("Hasło")),
                  validator: (value) {
                    return _validate(value);
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                      onPressed: () {
                        if (_loginForm.currentState!.validate()) {
                          _loginForm.currentState!.save();
                          widget.callback();
                        }
                      },
                      child: const Text("Zaloguj")),
                ),
              ],
            )),
      ),
    );
  }
}
