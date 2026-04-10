class CreateInteractionRequest {
  final String userId;
  final String action;

  CreateInteractionRequest({required this.userId, required this.action});

  Map<String, dynamic> toJson() {
    return {"toUserId": userId, "action": action};
  }
}
