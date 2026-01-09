import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/features/moduls/auth/login/models/otp_verification_response.dart';

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

  Map<OnboardSteps, bool> toStepMap() {
    return {
      OnboardSteps.name: name ?? false,
      OnboardSteps.gender: gender ?? false,
      OnboardSteps.dob: dob ?? false,
      OnboardSteps.height: height ?? false,
      OnboardSteps.dateWith: dateWith ?? false,
      OnboardSteps.allOfame: allOfame ?? false,
    };
  }

  int get firstIncompleteIndex =>
      toStepStatusList().indexWhere((e) => e == false);
}
