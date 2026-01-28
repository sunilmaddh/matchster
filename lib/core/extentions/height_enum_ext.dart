import 'package:matchster/core/enum/enum.dart';

extension HeightEnumExt on HeightEnum {
  String get emoji {
    switch (this) {
      case HeightEnum.height:
        return "📏";
    }
  }

  String get apiValue {
    switch (this) {
      case HeightEnum.height:
        return "height";
    }
  }

  static HeightEnum? fromApi(String apiValue) {
    return HeightEnum.values.firstWhere(
      (e) => e.apiValue == apiValue.toLowerCase(),
      orElse: () => HeightEnum.height,
    );
  }
}
