import 'package:app_learn/api_client/lecture_api_client.dart';
import 'package:app_learn/data_providers/session_data_provider.dart';
import 'package:app_learn/entities/lectures.dart';
import 'package:flutter/material.dart';

class LectureDetailData {
  late String name = '';
  late String image = '';
  late String text = '';
  late String videoUrl = '';
  int currentPage = 0;
  bool isFinished = false;
  bool isLoading = true;
}

class LectureDetailViewModel extends ChangeNotifier {
  final _lectureApiClient = LectureApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final String lectureId;
  final data = LectureDetailData();

  LectureDetailViewModel(this.lectureId);

  Future<void> setup(BuildContext context) async {
    updateData(null, false);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      final userId = await _sessionDataProvider.getAccountId();
      if (userId == null) {
        return;
      }
      final lecture = await _lectureApiClient.getLecture(userId, lectureId);
      updateData(lecture, true);
    } catch (e) {
      print(e);
    }
  }

  void updateData(Lecture? details, bool isFavorite) {
    data.name = details?.name ?? 'Загрузка...';
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }

    data.name = details.name;
    data.image = details.image;
    data.text = details.text;
    data.currentPage = details.currentPage;
    data.isFinished = details.isFinished;
    data.videoUrl = details.videoUrl;
    notifyListeners();
  }

  Future<void> savePage(BuildContext context) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _lectureApiClient.savePage(data.currentPage, accountId, lectureId);
  }
}
