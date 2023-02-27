import 'package:app_perbelanjaan/controllers/detail_controller.dart';
import 'package:app_perbelanjaan/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DetailWidget extends StatelessWidget {
  DetailWidget({super.key});

  final TextEditingController qtyC = TextEditingController(text: "1");
  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Product"),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 55),
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
                        const Text("|"),
                        const SizedBox(width: 10),
                        Text("${product.rating.count} Terjual"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Deskripsi Produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description.toString(),
                      style: const TextStyle(
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
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CartSizeButton(
                    cartSize: "-",
                    controller: controller,
                    qtyC: qtyC,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          var qty = int.parse(value);
                          controller.setQty(qty);
                        },
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^0+'), //users can't type 0 at 1st position
                          ),
                        ],
                        textAlign: TextAlign.center,
                        controller: qtyC,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          hintText: "qty",
                        ),
                      ),
                    ),
                  ),
                  CartSizeButton(
                    cartSize: "+",
                    controller: controller,
                    qtyC: qtyC,
                  ),
                  const Flexible(child: SizedBox()),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.qty.value < 1) {}
                        },
                        child: const Text("BUY NOW"),
                      ),
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

class CartSizeButton extends StatelessWidget {
  const CartSizeButton({
    Key? key,
    required this.cartSize,
    required this.controller,
    required this.qtyC,
  }) : super(key: key);

  final String cartSize;
  final DetailController controller;
  final TextEditingController qtyC;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (cartSize == "+") {
            controller.increment();
            qtyC.text = "${controller.qty.value}";
            debugPrint("QTY: ${controller.qty.value}");
          } else if (controller.qty.value > 1) {
            controller.decrement();
            qtyC.text = "${controller.qty.value}";
            debugPrint("QTY: ${controller.qty.value}");
          }
          qtyC.selection = TextSelection.collapsed(offset: qtyC.text.length);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(cartSize),
        ),
      ),
    );
  }
}
