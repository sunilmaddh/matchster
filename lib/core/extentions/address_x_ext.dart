extension AddressX on String {
  String get city {
    final parts = split(',');
    return parts.length > 1 ? parts.last.trim() : trim();
  }
}
