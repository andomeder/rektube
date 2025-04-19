import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rektube/configs/constants.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: secureStorageAuthTokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return _storage.read(key: secureStorageAuthTokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: secureStorageUserIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: secureStorageUserIdKey);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: secureStorageAuthTokenKey);
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: secureStorageUserIdKey);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}