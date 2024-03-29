import 'package:blog/data/services/users_service.dart';
import 'package:blog/screens/login_screen.dart';
import 'package:blog/utils/constants.dart';
import 'package:blog/utils/styles.dart';
import 'package:blog/widgets/customFlutterToast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  _register(email, username, password) async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await UserService.create(
          {'username': username, 'email': email, 'password': password});
      emailController.text = "";
      usernameController.text = "";
      passwordController.text = "";
      customFlutterToast(msg: "Utilisateur créé avec succès");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on DioError catch (e) {
      print(e.response);
      Map<String, dynamic>? error = e.response?.data;
      if (error != null && error.containsKey('message')) {
        customFlutterToast(msg: error['message']);
      } else {
        customFlutterToast(msg: "Une erreur est survenue veuillez rééssayer");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Inscription",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          // hintText: "Entrez votre pseudo",
                          labelText: "Pseudo",
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          // hintText: "Entrez votre e-mail",
                          labelText: "E-mail",
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        // hintText: "Entrez votre mot de passe",
                        labelText: "Mot de passe",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: _passwordVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        style: customStyle(context),
                        onPressed: () async {
                          if (!isLoading && formKey.currentState!.validate()) {
                            await _register(
                                emailController.text,
                                usernameController.text,
                                passwordController.text);
                            emailController.text = "";
                            usernameController.text = "";
                            passwordController.text = "";
                          }
                        },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 3))
                            : const Text("S'inscrire"))
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Vous avez un compte ?",
                    style: TextStyle(fontSize: 15)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(" Connectez vous",
                      style: TextStyle(fontSize: 17, color: appBlue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
