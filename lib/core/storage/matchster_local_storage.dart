import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:matchster/core/storage/storage_keys.dart';
import 'package:matchster/core/storage/storages_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchsterLocalStorage {
  MatchsterLocalStorage._internal();

  static final MatchsterLocalStorage _instance =
      MatchsterLocalStorage._internal();

  static MatchsterLocalStorage get instance => _instance;

  SharedPreferences? _preferences;

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(),
  );

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  void _checkInit() {
    if (_preferences == null) {
      throw Exception(StorageStrings.storageNotInitialized);
    }
  }

  SharedPreferences get _prefs {
    _checkInit();
    return _preferences!;
  }

  Future<void> clearAll() async {
    _checkInit();
    await _prefs.clear();
    await _secureStorage.deleteAll();
  }

  Future<void> clearSession() async {
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteUserId();
    await deleteUserEmail();
  }

  Future<void> _saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String _getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  Future<void> _saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool _getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  Future<void> _saveSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String> _getSecureString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  Future<void> _deleteSecureString(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Secure storage
  Future<void> saveUserId(String userId) async {
    await _saveSecureString(StorageKeys.userId, userId);
  }

  Future<String> getUserId() async {
    return _getSecureString(StorageKeys.userId);
  }

  Future<void> deleteUserId() async {
    await _deleteSecureString(StorageKeys.userId);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _saveSecureString(StorageKeys.accessToken, accessToken);
  }

  Future<String> getAccessToken() async {
    return _getSecureString(StorageKeys.accessToken);
  }

  Future<void> deleteAccessToken() async {
    await _deleteSecureString(StorageKeys.accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _saveSecureString(StorageKeys.refreshToken, refreshToken);
  }

  Future<String> getRefreshToken() async {
    return _getSecureString(StorageKeys.refreshToken);
  }

  Future<void> deleteRefreshToken() async {
    await _deleteSecureString(StorageKeys.refreshToken);
  }

  Future<void> saveUserEmail(String userEmail) async {
    await _saveSecureString(StorageKeys.userEmail, userEmail);
  }

  Future<String> getUserEmail() async {
    return _getSecureString(StorageKeys.userEmail);
  }

  Future<void> deleteUserEmail() async {
    await _deleteSecureString(StorageKeys.userEmail);
  }

  // SharedPreferences
  Future<void> saveWalkScreen(bool walkScreen) async {
    await _saveBool(StorageKeys.walkScreen, walkScreen);
  }

  Future<bool> getWalkScreen() async {
    return _getBool(StorageKeys.walkScreen);
  }

  Future<void> saveOnBoard(String onBoard) async {
    await _saveString(StorageKeys.onBoard, onBoard);
  }

  Future<String> getOnBoard() async {
    return _getString(StorageKeys.onBoard);
  }

  Future<void> saveUserName(String userName) async {
    await _saveString(StorageKeys.userName, userName);
  }

  Future<String> getUserName() async {
    return _getString(StorageKeys.userName);
  }

  Future<void> saveUserImage(String userImage) async {
    await _saveString(StorageKeys.userImage, userImage);
  }

  Future<String> getUserImage() async {
    return _getString(StorageKeys.userImage);
  }

  Future<void> saveHeight(String height) async {
    await _saveString(StorageKeys.height, height);
  }

  Future<String> getHeight() async {
    return _getString(StorageKeys.height);
  }

  Future<void> saveWeight(String weight) async {
    await _saveString(StorageKeys.weight, weight);
  }

  Future<String> getWeight() async {
    return _getString(StorageKeys.weight);
  }

  Future<void> saveAge(String age) async {
    await _saveString(StorageKeys.age, age);
  }

  Future<String> getAge() async {
    return _getString(StorageKeys.age);
  }

  Future<void> saveGenderType(String genderType) async {
    await _saveString(StorageKeys.genderType, genderType);
  }

  Future<String> getGenderType() async {
    return _getString(StorageKeys.genderType);
  }

  Future<void> saveSmokerType(String smokerType) async {
    await _saveString(StorageKeys.smokerType, smokerType);
  }

  Future<String> getSmokerType() async {
    return _getString(StorageKeys.smokerType);
  }

  Future<void> saveHistoryType(bool historyType) async {
    await _saveBool(StorageKeys.historyType, historyType);
  }

  Future<bool> getHistoryType() async {
    return _getBool(StorageKeys.historyType);
  }

  Future<void> saveProfilePopupShown(bool shown) async {
    _checkInit();
    await _preferences!.setBool("profile_popup_shown", shown);
  }

  Future<bool> getProfilePopupShown() async {
    _checkInit();
    return _preferences!.getBool("profile_popup_shown") ?? false;
  }

  Future<void> clearAllData() async {
    _checkInit();
    await _preferences!.clear();
  }

  Future<void> logout() async {
    _checkInit();
    await _preferences!.remove("access_token");
    await _preferences!.remove("refresh_token");
    await _preferences!.remove("user_id");
    await _preferences!.remove("user_name");
    await _preferences!.remove("user_email");
    await _preferences!.remove("user_image");
    await _preferences!.remove("profile_popup_shown");
  }
}