import 'package:app_perbelanjaan/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  setLogoutPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove("isLoggedIn");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        setLogoutPref();
                        AppRoutes.toLogin();
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("LOGOUT"),
        ),
      ),
    );
  }
}
