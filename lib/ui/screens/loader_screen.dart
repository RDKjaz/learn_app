import 'package:app_learn/data_providers/box_manager.dart';
import 'package:app_learn/entities/lectures.dart';
import 'package:app_learn/entities/tests.dart';
import 'package:app_learn/entities/user.dart';
import 'package:app_learn/navigation/main_navigation.dart';
import 'package:app_learn/services/auth_service.dart';
import 'package:app_learn/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.mainDarkBlue,
        ),
      ),
    );
  }
}

class LoaderScreenViewModel {
  BuildContext context;
  final _authService = AuthService();

  LoaderScreenViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkFirstSeen();
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    await Future.delayed(const Duration(milliseconds: 500));
    final nextScreen = isAuth
        ? MainNavigationRoutesNames.mainScreen
        : MainNavigationRoutesNames.auth;
    toNextScreen(nextScreen);
  }

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (!_seen) {
      await prefs.setBool('seen', true);
      await initDb();
    }
  }

  void toNextScreen(String nextScreen) =>
      Navigator.of(context).pushReplacementNamed(nextScreen);

  Future<void> initDb() async {
    final user1 = User(login: "v", password: "v", id: Uuid().v1().toString());
    final user2 = User(login: "1", password: "1", id: Uuid().v1().toString());
    final user3 = User(login: "a", password: "a", id: Uuid().v1().toString());
    final user4 = User(login: "2", password: "2", id: Uuid().v1().toString());

    final users = [user1, user2, user3, user4];

    final userBox = await BoxManager.instance.openUserBox();
    for (var user in users) {
      final lectures = createLectures();
      final tests = await createTests();

      final lectureBox = await BoxManager.instance.openLecturesBox(user.id);
      await lectureBox.addAll(lectures);
      await BoxManager.instance.closeBox(lectureBox);

      final testBox = await BoxManager.instance.openTestsBox(user.id);
      await testBox.addAll(tests);
      await BoxManager.instance.closeBox(testBox);

      user.lectures = HiveList(lectureBox);
      user.tests = HiveList(testBox);
    }

    await userBox.addAll([user1, user2, user3, user4]);
    await BoxManager.instance.closeBox(userBox);
  }

  List<Lecture> createLectures() {
    final id1 = Uuid().v1().toString();
    final id2 = Uuid().v1().toString();
    final id3 = Uuid().v1().toString();
    final id4 = Uuid().v1().toString();
    final id5 = Uuid().v1().toString();
    final lecture1 = Lecture(
        currentPage: 0,
        videoUrl: "https://www.youtube.com/watch?v=iIurlWiwgFA",
        isFinished: false,
        id: id1,
        name: "Название $id1",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation"
            "ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputa");
    final lecture2 = Lecture(
        currentPage: 0,
        videoUrl: "https://www.youtube.com/watch?v=iIurlWiwgFA",
        isFinished: false,
        id: id2,
        name: "Название $id2",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy");
    final lecture3 = Lecture(
        currentPage: 0,
        videoUrl: "https://www.youtube.com/watch?v=iIurlWiwgFA",
        isFinished: false,
        id: id3,
        name: "Название $id3",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text:
            "Ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputa");
    final lecture4 = Lecture(
        currentPage: 0,
        videoUrl: "https://www.youtube.com/watch?v=iIurlWiwgFA",
        isFinished: false,
        id: id4,
        name: "Название $id4",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy");
    final lecture5 = Lecture(
        currentPage: 0,
        videoUrl: "https://www.youtube.com/watch?v=iIurlWiwgFA",
        isFinished: false,
        id: id5,
        name: "Название $id5",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy");

    final list = <Lecture>[lecture1, lecture2, lecture3, lecture4, lecture5];
    return list;
  }

  Future<List<Test>> createTests() async {
    final id1 = Uuid().v1().toString();
    final id2 = Uuid().v1().toString();
    final id3 = Uuid().v1().toString();

    final id4 = Uuid().v1().toString();
    final id5 = Uuid().v1().toString();
    final id6 = Uuid().v1().toString();
    final question1 = TestQuestion(id: id4, image: null, text: "Вопрос 1");
    final question2 = TestQuestion(id: id5, image: null, text: "Вопрос 2");
    final question3 = TestQuestion(id: id6, image: null, text: "Вопрос 3");
    final qa = <TestQuestion>[question1, question2, question3];

    final id7 = Uuid().v1().toString();
    final id8 = Uuid().v1().toString();
    final id9 = Uuid().v1().toString();
    final answer1 = TestAnswer(id: id7, text: "Ответ 1 верный", isRight: true);
    final answer2 = TestAnswer(id: id8, text: "Ответ 2", isRight: false);
    final answer3 = TestAnswer(id: id9, text: "Ответ 3", isRight: false);
    final id10 = Uuid().v1().toString();
    final id11 = Uuid().v1().toString();
    final id12 = Uuid().v1().toString();
    final answer4 = TestAnswer(id: id10, text: "Ответ 4", isRight: false);
    final answer5 = TestAnswer(id: id11, text: "Ответ 5 верный", isRight: true);
    final answer6 = TestAnswer(id: id12, text: "Ответ 6", isRight: false);
    final id13 = Uuid().v1().toString();
    final id14 = Uuid().v1().toString();
    final id15 = Uuid().v1().toString();
    final answer7 = TestAnswer(id: id13, text: "Ответ 7", isRight: false);
    final answer8 = TestAnswer(id: id14, text: "Ответ 8", isRight: false);
    final answer9 = TestAnswer(id: id15, text: "Ответ 9 верный", isRight: true);
    final a1 = <TestAnswer>[
      answer1,
      answer2,
      answer3,
    ];
    final a2 = <TestAnswer>[
      answer4,
      answer5,
      answer6,
    ];
    final a3 = <TestAnswer>[answer7, answer8, answer9];

    final questionBox = await BoxManager.instance.openQuestionsBox(id1);

    final answerBox1 = await BoxManager.instance.openAnswersBox(id4);
    await answerBox1.addAll(a1);
    await BoxManager.instance.closeBox(answerBox1);

    final answerBox2 = await BoxManager.instance.openAnswersBox(id5);
    await answerBox2.addAll(a2);
    await BoxManager.instance.closeBox(answerBox2);

    final answerBox3 = await BoxManager.instance.openAnswersBox(id6);
    await answerBox3.addAll(a3);
    await BoxManager.instance.closeBox(answerBox3);

    await questionBox.addAll(qa);
    await BoxManager.instance.closeBox(questionBox);

    question1.answers = HiveList(answerBox1);
    question2.answers = HiveList(answerBox2);
    question3.answers = HiveList(answerBox3);

    final test1 = Test(
        id: id1,
        name: "Тест название $id1",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text: "Текст",
        questionsCount: 3);
    test1.questions = HiveList(questionBox);
    final test2 = Test(
        id: id2,
        name: "Тест название $id2",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text: "Текст",
        questionsCount: 3);
    final test3 = Test(
        id: id3,
        name: "Тест название $id3",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
        text: "Текст",
        questionsCount: 3);

    final list = <Test>[test1, test2, test3];
    return list;
  }
}
