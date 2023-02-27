import 'package:app_perbelanjaan/app_routes.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products?.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => AppRoutes.toDetail(products?[index]),
        title: Text(products?[index].title ?? ""),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(products?[index].image ?? ""),
        ),
        trailing: Text("\$${products?[index].price}"),
      ),
    );
  }
}
