import 'package:app_learn/data_providers/box_manager.dart';
import 'package:uuid/uuid.dart';

/// Апи клиент для авторизации
class AuthApiClient {
  /// Авторизоваться
  Future<(String, String)> auth({
    required String username,
    required String password,
  }) async {
    final (sessionId, accountId) = await _validateUser(
      username: username,
      password: password,
    );

    return (sessionId, accountId);
  }

  Future<(String, String)> _validateUser({
    required String username,
    required String password,
  }) async {
    final box = await BoxManager.instance.openUserBox();
    final user = box.values
        .where((element) =>
            element.login == username && element.password == password)
        .firstOrNull;
    if (user != null) {
      await BoxManager.instance.closeBox(box);
      return (const Uuid().v1().toString(), user.id);
    }
    await BoxManager.instance.closeBox(box);
    throw Exception("Ошибка авторизации");
  }
}
