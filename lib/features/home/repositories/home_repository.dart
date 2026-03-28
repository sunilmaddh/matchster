import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/like_response.dart';
import 'package:matchster/features/home/models/requests/create_interaction_request.dart';
import 'package:matchster/features/home/models/requests/get_profile_request.dart';
import 'package:matchster/features/home/services/home_service.dart';

class HomeRepository {
  HomeRepository({required this.homeService});
  final HomeService homeService;
  Future<BaseResponse<HomeResponse>> getProfileList({
    required GetProfileRequest request,
  }) async {
    return homeService.getProfileList(request: request);
  }

  Future<BaseResponse<void>> createInterection({
    required CreateInteractionRequest request,
  }) {
    return homeService.createInterection(request: request);
  }

  Future<BaseResponse<LikeResponse>> likeOnMe() {
    return homeService.likeOnMe();
  }
}
