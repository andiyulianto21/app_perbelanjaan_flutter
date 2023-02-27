import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import 'listview_product.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.replaceRange(0, 1, category[0].toUpperCase()),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: getProductByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListViewProducts(products: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<Product>> getProductByCategory(String category) async {
    var url = Uri.parse("https://fakestoreapi.com/products/category/$category");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return productListFromJson(response.body);
    } else {
      throw Exception("The Product is Empty");
    }
  }
}
