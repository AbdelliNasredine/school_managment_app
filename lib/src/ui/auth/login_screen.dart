import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  late UserSpace space;
  LoginScreen({Key? key}) : super(key: key) {
    space = Get.parameters["space"] == "teacher"
        ? UserSpace.teacher
        : UserSpace.parent;
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = Get.find<AuthController>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "Ce champ est obligatoire";
                      }
                      if (!value.isEmail) {
                        return "Ce champ doit étre un email valid";
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Votre email",
                    isDense: true,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  obscureText: _showPassword,
                  controller: _password,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Ce champ est obligatoire";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Votre mot de passe",
                    isDense: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                      icon: Icon(
                        _showPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Obx(() {
                  return ElevatedButton(
                    onPressed: !_auth.isLoading ? _handleLogin : null,
                    child: !_auth.isLoading
                        ? Text("Login")
                        : CircularProgressIndicator(
                            color: Colors.grey[700],
                          ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _auth.login(
        _email.text,
        _password.text,
        widget.space,
      );
    }
  }
}
