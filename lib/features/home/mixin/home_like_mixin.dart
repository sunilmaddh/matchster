import 'package:get/get.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/home/models/like_response.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';

mixin HomeLikeMixin on GetxController {
  HomeRepository get homeRepository;
  RxBool get isLoading;
  RxString get errorMessage;
  RxList<Datum> get likeList;
  Future<void> likeOnMe() async {
    try {
      isLoading.value = true;
      final response = await homeRepository.likeOnMe();
      if (response.success && response.data != null) {
        likeList.assignAll(response.data!.data);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppMethods.appPrint(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
