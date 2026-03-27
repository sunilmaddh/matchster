import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/like_response.dart';
import 'package:matchster/features/home/services/home_service.dart';

class HomeRepository {
  HomeRepository({required this.homeService});
  final HomeService homeService;
  Future<BaseResponse<HomeResponse>> getProfileList({
    required String filterType,
    required int filterCount,
  }) async {
    return homeService.getProfileList(
      filterType: filterType,
      filter: filterCount,
    );
  }

  Future<BaseResponse<void>> createInterection({
    required String userId,
    required String action,
  }) {
    return homeService.createInterection(userId: userId, action: action);
  }

  Future<BaseResponse<LikeResponse>> likeOnMe() {
    return homeService.likeOnMe();
  }
}
