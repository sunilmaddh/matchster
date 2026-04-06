import 'package:matchster/features/auth/model/response/otp_verification_response.dart';

extension OnboardPagesExtension on OnboardPages {
  List<bool> toStepStatusList() {
    return [
      name ?? false,
      gender ?? false,
      dob ?? false,
      height ?? false,
      dateWith ?? false,
      allOfame ?? false,
    ];
  }
}

extension OnboardPagesExt on OnboardPages {
  bool get allCompleted =>
      name! && gender! && dob! && height! && dateWith! && allOfame!;

  List<bool> toStepStatusLists() => [
    name!,
    gender!,
    dob!,
    height!,
    dateWith!,
    allOfame!,
  ];
}
