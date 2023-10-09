import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String login;

  @HiveField(1)
  String password;

  @HiveField(2)
  String id;

  @HiveField(4)
  HiveList? lectures;

  @HiveField(5)
  HiveList? tests;

  User({
    required this.login,
    required this.password,
    required this.id,
  });
}
