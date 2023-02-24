import 'package:app_perbelanjaan/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Product"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * .4,
                          child: Image.network(product.image)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 18,
                          ignoreGestures: true,
                          onRatingUpdate: (value) {},
                          allowHalfRating: true,
                          minRating: 1,
                          maxRating: 5,
                          initialRating: product.rating.rate.toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text("${product.rating.rate}"),
                        const SizedBox(width: 10),
                        Text("|"),
                        const SizedBox(width: 10),
                        Text("${product.rating.count} Terjual"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Deskripsi Produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
