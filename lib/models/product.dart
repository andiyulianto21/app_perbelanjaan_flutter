import 'dart:convert';

List<Product> productListFromJson(String strJson) =>
    List<Product>.from(json.decode(strJson).map((x) => Product.fromJson(x)));

class Product {
  int id;
  String title;
  num? price;
  String? description;
  String? category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    this.price,
    this.description,
    this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  num rate = 0;
  int count = 0;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }
}
