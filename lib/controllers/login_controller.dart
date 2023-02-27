import 'package:get/get.dart';

class LoginController extends GetxController {
  var isHidden = false.obs;
  var isLoading = false.obs;

  setIsHidden() {
    isHidden.value = !isHidden.value;
  }

  setIsLoading() {
    isLoading.value = !isLoading.value;
  }
}
