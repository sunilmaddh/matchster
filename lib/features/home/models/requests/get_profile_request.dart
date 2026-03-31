class GetProfileRequest {
  final String filterType;
  final int distance;

  GetProfileRequest({required this.filterType, required this.distance});

  Map<String, dynamic> toJson() {
    return {
      "filterType": filterType,
      "filters": {"distance": distance},
    };
  }
}
