class ApiEndpoints {
  static const String baseUrl =
      "https://studio-blue-pierre-participants.trycloudflare.com";
  static const String apiPrefix = "/api/v1/matchster";
  static const String urlUserType = "$apiPrefix/user-auth";
  static const String urlProfileType = "$apiPrefix/user-profile";

  static const String sendOtp = "$urlUserType/send-otp",
      verifyOtp = "$urlUserType/verify-otp",
      addName = "$urlUserType/add-name",
      addGender = "$urlUserType/add-gender",
      addDob = "$urlUserType/add-dob",
      addHieght = "$urlUserType/add-height",
      addDateWith = "$urlUserType/add-datewith",
      uploadPhoto = "$urlUserType/hall-of-fame/media",
      allOfFame = "$urlUserType/hall-of-fame",
      addWorkout = "$urlProfileType/add-workout",
      addSmoking = "$urlProfileType/add-smoking",
      addDrinking = "$urlProfileType/add-drinking",
      addInterests = "$urlProfileType/add-interests",
      addLanguages = "$urlProfileType/add-languages",
      addZodiacsign = "$urlProfileType/add-zodiacsign",
      addReligion = "/$urlProfileType-religion",
      addVisibility = "$urlProfileType/add-visibility",
      addLookingfor = "$urlProfileType/add-lookingfor",
      addQualification = "$urlProfileType/add-qualification",
      addWork = "$urlProfileType/add-work",
      addAbout = "$urlProfileType/add-about";
}
