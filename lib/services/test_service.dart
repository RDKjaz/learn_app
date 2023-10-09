import 'package:app_learn/api_client/test_api_client.dart';
import 'package:app_learn/entities/tests.dart';

/// Сервис тестов
class TestService {
  final _testApiClient = TestApiClient();

  /// Получить тесты
  Future<Tests> getTests(String userId) async =>
      _testApiClient.getTests(userId);

  /// Получить тест
  Future<Test> getTest(String userId, String testId) async =>
      _testApiClient.getTest(userId, testId);
}
