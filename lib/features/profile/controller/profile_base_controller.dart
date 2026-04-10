import 'package:matchster/core/base/base_controller.dart';

abstract class ProfileBaseController extends BaseController {
  void setBusy(bool value) => isLoading.value = value;

  void setErrorMessage(String message) {
    errorMessage.value = message;
  }

  void setSuccessMessage(String message) {
    successMessage.value = message;
  }
}
