class ApiEndpoints {
  static const String baseUrl =
      //"https://acknowledge-tray-consequently-dim.trycloudflare.com";
      "http://209.38.123.49:8002/";
  //  "https://watt-clan-cabinet-formats.trycloudflare.com";
  static const String apiPrefix = "/api/v1/matchster";
  static const String urlUserType = "$apiPrefix/user-auth";
  static const String urlProfileType = "$apiPrefix/user-profile";
  static const String urlGoogleMap = "$apiPrefix/google-map";

  static const String urlInteractions = "$apiPrefix/interaction";
  static const String urlCsc = "$apiPrefix/csc";

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
      addReligion = "$urlProfileType/add-religion",
      addVisibility = "$urlProfileType/add-visibility",
      addLookingfor = "$urlProfileType/add-lookingfor",
      addQualification = "$urlProfileType/add-qualification",
      addWork = "$urlProfileType/add-work",
      addCurrentLocation = "$urlUserType/add-current-location",
      addHomeTownLocation = "$urlUserType/add-home-town-location",
      reverseGeocoding = "$urlGoogleMap/reverse-geocode",
      autoComplete = "$urlGoogleMap/auto-complete",
      placeDetails = "$urlGoogleMap/place-details",
      myProfile = "$urlProfileType/my-profile",
      getProfiles = "$urlInteractions/get-profiles",
      createInteraction = "$urlInteractions/create-interaction",
      addProfilePicture = "$urlUserType/hall-of-fame/add",
      deleteProfile = "$urlUserType/hall-of-fame",
      likesOnme = "$urlInteractions/likes-on-me",
      addAbout = "$urlProfileType/add-about",
      cscCountry = "$urlCsc/country",
      cscState = "$urlCsc/state",
      cscCity = "$urlCsc/city",
      uploadProfileimage = "$urlUserType/update-profile-pic",
      swipedProfiles = '$apiPrefix/interaction/swiped-profiles',
      sendEmailOtp = '$apiPrefix/user-profile/send-email-otp',
      verifyEmailOtp = '$apiPrefix/user-profile/verify-email-otp',
      swapFames = '$urlProfileType/swap-fames';
}
