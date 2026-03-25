import 'package:matchster/core/storage/matchster_local_storage.dart';

class TokenDebug {
  static Future<void> checkToken() async {
    try {
      final token = await MatchsterLocalStorage.instance.getAccessToken();
      print('=== TOKEN DEBUG ===');
      print('Token exists: ${token.isNotEmpty}');
      print('Token length: ${token.length}');
      print('Token preview: ${token.isNotEmpty ? token.substring(0, (token.length > 20 ? 20 : token.length)) + '...' : 'EMPTY'}');
      print('==================');
    } catch (e) {
      print('Error checking token: $e');
    }
  }

  static Future<void> printAllStoredData() async {
    try {
      final token = await MatchsterLocalStorage.instance.getAccessToken();
      final userId = await MatchsterLocalStorage.instance.getUserId();
      final userName = await MatchsterLocalStorage.instance.getUserName();
      final userEmail = await MatchsterLocalStorage.instance.getUserEmail();
      
      print('=== ALL STORED DATA ===');
      print('Access Token: ${token.isNotEmpty ? 'SAVED' : 'NOT SAVED'}');
      print('User ID: ${userId.isNotEmpty ? userId : 'NOT SAVED'}');
      print('User Name: ${userName.isNotEmpty ? userName : 'NOT SAVED'}');
      print('User Email: ${userEmail.isNotEmpty ? userEmail : 'NOT SAVED'}');
      print('=======================');
    } catch (e) {
      print('Error printing stored data: $e');
    }
  }
}
