import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LoginController extends GetxController {
  RxBool isLoginWithMobile = false.obs;
  RxString otpValue = "".obs;
  RxBool isEnable = false.obs;
  RxBool isAccessMyAccount = false.obs;
}
