import 'package:app_learn/api_client/test_api_client.dart';
import 'package:app_learn/data_providers/box_manager.dart';
import 'package:app_learn/data_providers/session_data_provider.dart';
import 'package:app_learn/entities/tests.dart';
import 'package:flutter/material.dart';

class TestDetailData {
  late String id = '';
  late String name = '';
  late String image = '';
  late int questionsCount = 0;
  List<TestQuestion> questions = <TestQuestion>[];
  Map<String, List<TestAnswer>> answers = <String, List<TestAnswer>>{};
  bool isLoading = true;
}

class TestDetailViewModel extends ChangeNotifier {
  final _testApiClient = TestApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final String testId;
  final data = TestDetailData();

  TestDetailViewModel(this.testId);

  Future<void> setup(BuildContext context) async {
    List<TestQuestion> t = <TestQuestion>[];
    updateData(null, t, null, false);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context) async {
    final userId = await _sessionDataProvider.getAccountId();
    if (userId == null) {
      return;
    }
    try {
      final test = await _testApiClient.getTest(userId, testId);
      var dict = <String, List<TestAnswer>>{};
      final questionsBox = await BoxManager.instance.openQuestionsBox(test.id);
      final questions = questionsBox.values.toList();
      for (var q in questions) {
        final answers = await BoxManager.instance.openAnswersBox(q.id);
        dict[q.id] = answers.values.toList();
        await BoxManager.instance.closeBox(answers);
      }
      await BoxManager.instance.closeBox(questionsBox);

      updateData(test, questions, dict, true);
    } catch (e) {
      print(e);
    }
  }

  void updateData(
    Test? test,
    List<TestQuestion> questions,
    Map<String, List<TestAnswer>>? answers,
    bool isFavorite,
  ) {
    data.name = test?.name ?? 'Загрузка...';
    data.isLoading = test == null;
    if (test == null || answers == null) {
      notifyListeners();
      return;
    }
    data.id = test.id;
    data.name = test.name;
    data.image = test.image;
    data.questionsCount = test.questionsCount;
    data.questions = questions;
    data.answers = answers;

    notifyListeners();
  }

  Future<void> saveResult(int result) async {
    final accountId = await _sessionDataProvider.getAccountId();
    if (accountId == null) {
      return;
    }
    final tests = await BoxManager.instance.openTestsBox(accountId);
    final test =
        tests.values.where((element) => element.id == data.id).firstOrNull;
    if (test != null) {
      test.result = result.toString();
      await test.save();
    }
    await BoxManager.instance.closeBox(tests);
  }
}
