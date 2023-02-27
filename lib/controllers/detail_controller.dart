import 'package:get/get.dart';

class DetailController extends GetxController {
  RxInt qty = 1.obs;

  setQty(int q) {
    qty.value = q;
  }

  isDisabled(int qty) {
    if (qty < 1) {
      true;
    } else {
      false;
    }
  }

  increment() => qty.value++;
  decrement() => qty.value--;
}
