class ApiEndpoints {
  static const String baseUrl =
      "https://agricultural-bald-partner-taxation.trycloudflare.com";
  static const String apiPrefix = "/api/v1/matchster";
  static const String urlType = "$apiPrefix/user-auth";
  static const String sendOtp = "$urlType/send-otp",
      verifyOtp = "$urlType/verify-otp",
      addName = "$urlType/add-name",
      addGender = "$urlType/add-gender",
      addDob = "$urlType/add-dob",
      addHieght = "$urlType/add-height",
      addDateWith = "$urlType/add-datewith";
}
