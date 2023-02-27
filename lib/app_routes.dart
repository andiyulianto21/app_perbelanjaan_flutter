import 'package:app_perbelanjaan/models/product.dart';
import 'package:app_perbelanjaan/widgets/product_category.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'widgets/category_widget.dart';
import 'widgets/detail_widget.dart';
import 'widgets/product_widget.dart';
import 'widgets/profile_widget.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String loginPage = "/";
  static const String homePage = "/home";
  static const String categorySelectedPage = "/product_category";
  static const String productPage = "/product";
  static const String profilePage = "/profile";
  static const String detailProductPage = "/detail_product";

  static final pages = [
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(name: profilePage, page: () => const ProfileWidget()),
    GetPage(name: categorySelectedPage, page: () => const ProductCategory()),
    GetPage(name: detailProductPage, page: () => DetailWidget()),
  ];

  static Future<dynamic>? toHome() => Get.offNamed(homePage);
  static Future<dynamic>? toLogin() => Get.offAllNamed(loginPage);
  static Future<dynamic>? toDetail(Product? product) =>
      Get.toNamed(detailProductPage, arguments: product);
  static Future<dynamic>? toCategorySelected(String categorySelected) =>
      Get.toNamed(categorySelectedPage, arguments: categorySelected);
  static Future<dynamic>? toProfile() => Get.toNamed(profilePage);
}
