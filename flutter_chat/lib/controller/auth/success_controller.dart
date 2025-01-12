import 'package:chat_application/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class SuccessSignUpController extends GetxController {
  goTochatLogin();
}

class SuccessSignUpControllerImp extends SuccessSignUpController {
  @override
  goTochatLogin() {
    Get.offAllNamed(AppRoute.homeTest);
  }
}
