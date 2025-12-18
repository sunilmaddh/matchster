import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoginWithMobile = false.obs;
  RxString otpValue = "".obs;
  RxBool isEnable = false.obs;
  RxBool isOtpEnable = false.obs;
  RxBool isAccessMyAccount = false.obs;
}
