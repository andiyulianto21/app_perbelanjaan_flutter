import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inputUsernameC = TextEditingController();

  TextEditingController inputPasswordC = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Your Username input is empty";
                    }
                    return null;
                  },
                  controller: inputUsernameC,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Input your username",
                      labelText: "Username"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Your password input is empty";
                    }
                    return null;
                  },
                  controller: inputPasswordC,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Input your password",
                    labelText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLoading != true) login(context);
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext ctx) {
    if (formGlobalKey.currentState!.validate()) {
      validate(ctx);
    }
  }

  void validate(BuildContext ctx) async {
    setState(() {
      isLoading = true;
    });

    var response = await http
        .post(Uri.parse("https://fakestoreapi.com/auth/login"), body: {
      "username": inputUsernameC.text,
      "password": inputPasswordC.text
    });
    if (!mounted) return;
    var body = response.body;
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(ctx, '/home');
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(body),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }
}
