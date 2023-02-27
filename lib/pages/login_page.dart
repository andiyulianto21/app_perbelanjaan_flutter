import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/app_routes.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController inputUsernameC = TextEditingController();
  TextEditingController inputPasswordC = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  // bool isLoading = false;
  var controller = Get.put(LoginController());

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
                Obx(
                  () => TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Your password input is empty";
                      }
                      return null;
                    },
                    controller: inputPasswordC,
                    obscureText: controller.isHidden.value,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Input your password",
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.setIsHidden();
                        },
                        icon: Icon(
                          controller.isHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
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
                      if (!controller.isLoading.value) {
                        debugPrint("CAN CLICK");
                        login(context);
                      }
                    },
                    child: Obx(
                      () => controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 18),
                            ),
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

  setIsLoggedInPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("isLoggedIn", true);
  }

  void validate(BuildContext ctx) async {
    controller.setIsLoading();
    var response = await http
        .post(Uri.parse("https://fakestoreapi.com/auth/login"), body: {
      "username": inputUsernameC.text,
      "password": inputPasswordC.text
    });
    // if (!mounted) return;
    var body = response.body;
    if (response.statusCode == 200) {
      setIsLoggedInPref();
      AppRoutes.toHome();
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(body),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    controller.setIsLoading();
  }
}
