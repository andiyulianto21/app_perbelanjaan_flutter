import 'package:app_perbelanjaan/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data!) ? const HomePage() : LoginPage();
          }
          return LoginPage();
        },
      ),
      initialRoute: AppRoutes.loginPage,
      getPages: AppRoutes.pages,
    );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin = pref.getBool("isLoggedIn") ?? false;
    return isLogin;
  }
}
