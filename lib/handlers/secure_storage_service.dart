import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveSession(String token) async {
    await _storage.write(key: 'session', value: token);
  }

  Future<String?> getSession() async {
    return await _storage.read(key: 'session');
  }

  Future<void> deleteSession() async {
    await _storage.delete(key: 'session');
  }
}
