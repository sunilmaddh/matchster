// enum GenderEnum {
//   men,
//   women,
//   others,
// }
enum GenderEnum {
  men,
  women,
  others,

  // final String value;
  // const GenderEnum(this.value);
}

// extension GenderEnumX on GenderEnum {
//   static GenderEnum fromValue(String value) {
//     return GenderEnum.values.firstWhere(
//       (e) => e.value == value,
//       orElse: () => GenderEnum.others,
//     );
//   }
// }
