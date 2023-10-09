import 'package:hive_flutter/hive_flutter.dart';

part 'lectures.g.dart';

class Lectures {
  final List<Lecture> lectures;
  final int totalResults;

  Lectures({
    required this.lectures,
    required this.totalResults,
  });
}

@HiveType(typeId: 2)
class Lecture extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String text;
  @HiveField(4)
  int currentPage;
  @HiveField(5)
  final bool isFinished;
  @HiveField(6)
  final String? videoUrl;
  @HiveField(7)
  final List<String>? links;

  Lecture({
    this.image,
    this.videoUrl,
    this.links,
    required this.id,
    required this.name,
    required this.text,
    required this.currentPage,
    required this.isFinished,
  });
}
