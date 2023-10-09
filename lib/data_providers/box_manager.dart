import 'package:app_learn/entities/lectures.dart';
import 'package:app_learn/entities/tests.dart';
import 'package:app_learn/entities/user.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};

  BoxManager._();

  Future<Box<User>> openUserBox() async =>
      _openBox('users_box', 1, UserAdapter());

  Future<Box<Lecture>> openLecturesBox(String userId) async =>
      _openBox(makeLectureBoxName(userId), 2, LectureAdapter());

  Future<Box<Test>> openTestsBox(String userId) async =>
      _openBox(makeTestBoxName(userId), 3, TestAdapter());

  Future<Box<TestQuestion>> openQuestionsBox(String testId) async =>
      _openBox(makeQuestionBoxName(testId), 4, TestQuestionAdapter());

  Future<Box<TestAnswer>> openAnswersBox(String questionId) async =>
      _openBox(makeAnswerBoxName(questionId), 5, TestAnswerAdapter());

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    var count = _boxCounter[box.name] ?? 1;
    count -= 1;
    _boxCounter[box.name] = count - 1;
    if (count > 0) return;

    await box.compact();
    await box.close();
  }

  String makeLectureBoxName(String userId) => 'lectures_box_$userId';
  String makeTestBoxName(String userId) => 'tests_box_$userId';
  String makeQuestionBoxName(String testId) => 'questions_box_$testId';
  String makeAnswerBoxName(String questionId) => 'answers_box_$questionId';

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.box(name);
    }
    _boxCounter[name] = 1;

    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
