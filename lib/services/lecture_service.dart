import 'package:app_learn/api_client/lecture_api_client.dart';
import 'package:app_learn/entities/lectures.dart';

/// Сервис лекций
class LectureService {
  final _lectureApiClient = LectureApiClient();

  /// Получить лекции
  Future<Lectures> getLectures(String userId) async =>
      _lectureApiClient.getLectures(userId);

  /// Получить лекцию
  Future<Lecture> getLecture(String userId, String lectureId) async =>
      _lectureApiClient.getLecture(userId, lectureId);

  /// Сохрнаить страницу
  Future<void> savePage(int page, String userId, String lectureId) async =>
      _lectureApiClient.savePage(page, userId, lectureId);
}
