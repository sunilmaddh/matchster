import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/models/like_response.dart';

class HomeServices {
  final _baseServices = BaseService();

  Future<BaseResponse<HomeResponse>> getProfileLisr({
    required String filterType,
    required int filter,
  }) async {
    return _baseServices.postRequest<HomeResponse>(
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
    return _baseServices.postRequest(
      path: ApiEndpoints.createInteraction,
      data: {"toUserId": userId, "action": action},
    );
  }

  Future<BaseResponse<LikeResponse>> likeOnMe() async {
    return _baseServices.getRequest<LikeResponse>(
      path: ApiEndpoints.likesOnme,
      fromJsonT: (json) => LikeResponse.fromJson(json),
    );
  }
}
