import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import 'listview_product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FutureBuilder(
        future: getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);
            var products = snapshot.data;
            return ListViewProducts(products: products);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Product>> getAllProducts() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return productListFromJson(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
