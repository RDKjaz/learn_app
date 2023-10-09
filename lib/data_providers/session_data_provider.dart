import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Названия ключей
abstract class _Keys {
  static const sessionId = 'session_id';
  static const accountId = 'account_id';
}

/// Провайдер сессии
class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  /// Получить идентификатор сессии
  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);

  /// Установить идентификатор сессии
  Future<void> setSessionId(String value) =>
      _secureStorage.write(key: _Keys.sessionId, value: value);

  /// Удалить идентификатор сессии
  Future<void> deleteSessionId() => _secureStorage.delete(key: _Keys.sessionId);

  /// Получить идентификатор аккаунта
  Future<String?> getAccountId() async {
    final accountId = await _secureStorage.read(key: _Keys.accountId);
    return accountId;
  }

  /// Получить идентификатор аккаунта
  Future<void> setAccountId(String value) =>
      _secureStorage.write(key: _Keys.accountId, value: value);

  /// Удалить идентификатор аккаунта
  Future<void> deleteAccountId() => _secureStorage.delete(key: _Keys.accountId);
}
