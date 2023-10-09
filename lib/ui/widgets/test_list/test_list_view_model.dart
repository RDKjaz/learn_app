import 'dart:async';
import 'package:app_learn/data_providers/box_manager.dart';
import 'package:app_learn/data_providers/session_data_provider.dart';
import 'package:app_learn/entities/tests.dart';
import 'package:app_learn/navigation/main_navigation.dart';
import 'package:app_learn/services/test_service.dart';
import 'package:flutter/material.dart';

class TestListRowData {
  final String id;
  final String name;
  final String image;
  final String result;
  final int count;

  TestListRowData({
    required this.id,
    required this.name,
    required this.image,
    required this.result,
    required this.count,
  });
}

class TestListViewModel extends ChangeNotifier {
  final _testService = TestService();
  final _sessionDataProvider = SessionDataProvider();

  var _tests = <TestListRowData>[];
  List<TestListRowData> get tests => List.unmodifiable(_tests);

  TestListViewModel();

  Future<void> _load() async {
    final accountId = await _sessionDataProvider.getAccountId();
    if (accountId == null) {
      return;
    }
    var t = await _testService.getTests(accountId);
    final box = await BoxManager.instance.openTestsBox(accountId);
    _tests = t.tests.map(_makeRowData).toList();
    BoxManager.instance.closeBox(box);
    notifyListeners();
  }

  TestListRowData _makeRowData(Test test) {
    return TestListRowData(
        id: test.id,
        name: test.name,
        image: test.image,
        result: test.result ?? "0",
        count: test.questionsCount);
  }

  void onTestTap(BuildContext context, int index) {
    final id = _tests[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRoutesNames.testDetail, arguments: id);
  }

  void showedTestAtIndex(int index) {
    if (index < _tests.length - 1) return;
    _load();
  }

  Future<void> setup(BuildContext context) async {
    await _load();
  }
}
