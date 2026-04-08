extension SnakeCaseExtension on String {
  String toSnakeCase() {
    return trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
  }
}

extension StringExtension on String {
  String toCapitalizedWords() {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }
}

extension StringSnakCaseExtension on String {
  String removeSnakeAndCapitalize() {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }
}

// extension StringSnakExtension on String {
//   // String toSnakeCaseLowerCase() {
//   //   return trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
//   // }

// }
extension StringSnakExtension on String {
  String toSnakeCaseLowerCase() {
    return trim()
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s]"), "") // remove special chars like '
        .replaceAll(RegExp(r'\s+'), '_'); // replace spaces with _
  }
}
