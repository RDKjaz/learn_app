import 'package:hive_flutter/hive_flutter.dart';

part 'tests.g.dart';

class Tests {
  final List<Test> tests;
  final int totalResults;

  Tests({
    required this.tests,
    required this.totalResults,
  });
}

@HiveType(typeId: 3)
class Test extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String text;
  @HiveField(4)
  String? result;
  @HiveField(5)
  int questionsCount;
  @HiveField(6)
  HiveList? questions;

  Test(
      {this.result,
      required this.id,
      required this.name,
      required this.image,
      required this.text,
      required this.questionsCount});
}

@HiveType(typeId: 4)
class TestQuestion extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final String text;
  @HiveField(4)
  HiveList? answers;

  TestQuestion({
    required this.id,
    required this.image,
    required this.text,
  });
}

@HiveType(typeId: 5)
class TestAnswer extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final bool isRight;

  TestAnswer({
    required this.id,
    required this.text,
    required this.isRight,
  });
}
