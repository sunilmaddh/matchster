import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/modules/home/models/home_response.dart';
import 'package:matchster/features/modules/home/models/like_response.dart';

class HomeService {
  HomeService({required this.baseServices});
  final BaseService baseServices;

  Future<BaseResponse<HomeResponse>> getProfileList({
    required String filterType,
    required int filter,
  }) async {
    return baseServices.postRequest<HomeResponse>(
      path: ApiEndpoints.getProfiles,
      data: {
        "filterType": filterType,
        "filters": {"distance": filter},
      },
      fromJsonT: (json) => HomeResponse.fromJson(json),
    );
  }

  Future<BaseResponse<void>> createInterection({
    required String userId,
    required String action,
  }) async {
    return baseServices.postRequest(
      path: ApiEndpoints.createInteraction,
      data: {"toUserId": userId, "action": action},
    );
  }

  Future<BaseResponse<LikeResponse>> likeOnMe() async {
    return baseServices.getRequest<LikeResponse>(
      path: ApiEndpoints.likesOnme,
      fromJsonT: (json) => LikeResponse.fromJson(json),
    );
  }
}
