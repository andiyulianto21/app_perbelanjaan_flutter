import 'dart:convert';

import 'package:app_perbelanjaan/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: FutureBuilder(
          future: getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return GridView.builder(
                itemCount: data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppRoutes.toCategorySelected(data[index]);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            data[index].toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List<String>> getAllCategories() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products/categories");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body).map((x) => x));
    } else {
      throw Exception("There is error");
    }
  }
}
