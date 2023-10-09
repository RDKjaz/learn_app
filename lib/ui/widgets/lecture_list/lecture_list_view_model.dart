import 'dart:async';
import 'package:app_learn/data_providers/session_data_provider.dart';
import 'package:app_learn/entities/lectures.dart';
import 'package:app_learn/navigation/main_navigation.dart';
import 'package:app_learn/services/lecture_service.dart';
import 'package:flutter/material.dart';

class LectureListRowData {
  final String id;
  final String name;
  final String? image;
  final String description;

  LectureListRowData({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });
}

class LectureListViewModel extends ChangeNotifier {
  final _lectureService = LectureService();
  final _sessionDataProvider = SessionDataProvider();

  var _lectures = <LectureListRowData>[];
  List<LectureListRowData> get lectures => List.unmodifiable(_lectures);

  LectureListViewModel();

  Future<void> _load() async {
    final accountId = await _sessionDataProvider.getAccountId();
    if (accountId == null) {
      return;
    }
    var l = await _lectureService.getLectures(accountId);
    _lectures = l.lectures.map(_makeRowData).toList();
    notifyListeners();
  }

  LectureListRowData _makeRowData(Lecture lecture) {
    return LectureListRowData(
        id: lecture.id,
        name: lecture.name,
        image: lecture.image,
        description: lecture.text);
  }

  void onLectureTap(BuildContext context, int index) {
    final id = _lectures[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRoutesNames.lectureDetail, arguments: id);
  }

  void showedLectureAtIndex(int index) {
    if (index < _lectures.length - 1) return;
    _load();
  }

  Future<void> setup(BuildContext context) async {
    await _load();
  }
}
