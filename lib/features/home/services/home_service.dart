import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/like_response.dart';
import 'package:matchster/features/home/models/requests/create_interaction_request.dart';
import 'package:matchster/features/home/models/requests/get_profile_request.dart';

class HomeService {
  HomeService({required this.baseServices});

  final BaseService baseServices;

  Future<BaseResponse<HomeResponse>> getProfileList({
    required GetProfileRequest request,
  }) async {
    return baseServices.postRequest<HomeResponse>(
      path: ApiEndpoints.getProfiles,
      data: request.toJson(),
      fromJsonT: (json) => HomeResponse.fromJson(json),
    );
  }

  Future<BaseResponse<void>> createInterection({
    required CreateInteractionRequest request,
  }) async {
    return baseServices.postRequest(
      path: ApiEndpoints.createInteraction,
      data: request.toJson(),
    );
  }

  Future<BaseResponse<LikeResponse>> likeOnMe() async {
    return baseServices.getRequest<LikeResponse>(
      path: ApiEndpoints.likesOnme,
      fromJsonT: (json) => LikeResponse.fromJson(json),
    );
  }
}
