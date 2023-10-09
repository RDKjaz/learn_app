import 'package:app_learn/api_client/auth_api_client.dart';
import 'package:app_learn/data_providers/session_data_provider.dart';

/// Сервис авторизации
class AuthService {
  final _authApiClient = AuthApiClient();
  final _sessionDataProvider = SessionDataProvider();

  /// Авторизован ли пользователь
  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  /// Залогиниться
  Future<void> login(String login, String password) async {
    final (sessionId, accountId) = await _authApiClient.auth(
      username: login,
      password: password,
    );

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }

  /// Разлогиниться
  Future<void> logout() async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteAccountId();
  }
}
