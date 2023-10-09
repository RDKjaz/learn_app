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

    final lecture1 = Lecture(
        image:
            "https://changellenge.com/upload/iblock/8fb/8fbfea7d04945d7c47c62d0617866ff7.jpg",
        currentPage: 0,
        isFinished: false,
        id: id1,
        name: "Лекция 1. Введение в Java.",
        text:
            "На сегодняшний момент язык Java является одним из самых распространенных и популярных языков программирования. Первая версия языка появилась еще в 1996 году в недрах компании Sun Microsystems, впоследствии поглощенной компанией Oracle. Java задумывался как универсальный язык программирования, который можно применять для различного рода задач. И к настоящему времени язык Java проделал большой путь, было издано множество различных версий. Текущей версией является Java 21, которая вышла в сентябре 2023 года. А Java превратилась из просто универсального языка в целую платформу и экосистему, которая объединяет различные технологии, используемые для целого ряда задач: от создания десктопных приложений до написания крупных веб-порталов и сервисов. Кроме того, язык Java активно применяется для создания программного обеспечения для множества устройств: обычных ПК, планшетов, смартфонов и мобильных телефонов и даже бытовой техники.\nОСОБЕННОСТИ JAVA\nКлючевой особенностью языка Java является то, что его код сначала транслируется в специальный байт-код, независимый от платформы. А затем этот байт-код выполняется виртуальной машиной JVM (Java Virtual Machine). В этом плане Java отличается от стандартных интерпретируемых языков как PHP или Perl, код которых сразу же выполняется интерпретатором. В то же время Java не является и чисто компилируемым языком, как С или С++. Подобная архитектура обеспечивает кроссплатформенность и аппаратную переносимость программ на Java, благодаря чему подобные программы без перекомпиляции могут выполняться на различных платформах - Windows, Linux, Mac OS и т.д. Для каждой из платформ может быть своя реализация виртуальной машины JVM, но каждая из них может выполнять один и тот же код. Еще одной ключевой особенностью Java является то, что она поддерживает автоматическую сборку мусора. А это значит, что вам не надо освобождать вручную память от ранее использовавшихся объектов, как в С++, так как сборщик мусора это сделает автоматически за вас. Java является объектно-ориентированным языком. Он поддерживает полиморфизм, наследование, статическую типизацию. Объектно-ориентированный подход позволяет решить задачи по построению крупных, но в тоже время гибких, масштабируемых и расширяемых приложений.");
    final lecture2 = Lecture(
        links: <String>[
          "https://www.oracle.com/java/technologies/downloads/",
          "https://openjdk.org/",
          "https://www.jetbrains.com/idea/download"
        ],
        image:
            "https://changellenge.com/upload/iblock/8fb/8fbfea7d04945d7c47c62d0617866ff7.jpg",
        videoUrl: "https://www.youtube.com/watch?v=xvUFqDKIKJE",
        currentPage: 0,
        isFinished: false,
        id: id2,
        name: "Лекция 2. Установка Java.",
        text:
            "Для разработки на языке программирования Java нам потребуется специальный комплект инструментов, который называется JDK или Java Development Kit. Однако стоит отметить, что существуют разные реализации JDK, хотя все они используют один и тот же язык - Java. Две наиболее популярных реализации - Oracle JDK и OpenJDK. Наибольшие различия с точки зрения лицензирования и поддержки. Согласно лицензии Oracle JDK можно использовать бесплатно для персональных нужд, а также для разработки, тестирования и демонстрации приложений. В остальных случаях (например, для получения поддержки) необходима коммерческая лицензия в виде подписки. А OpenJDK полностью бесплатна. Итак, для разработки программ на Java нам потребуется специальный комплект для разработки JDK (Java Development Kit). JDK включает ряд программ и утилит, которые позволяют компилировать, запускать программы на Java, а также выполнять ряд других функций. Загрузить и установить соответствующую версию JDK можно с официальных сайтов. Как правило, крупные программы разрабатываются с использованием таких средств как IDE или интегрированные среды разработки, которые упрощают и ускоряют написание кода и создание приложений. На данный момент одной из самых популярных сред разработки для Java является IntelliJ IDEA от компании JetBrains.");

    final list = <Lecture>[lecture1, lecture2];
    return list;
  }

  Future<List<Test>> createTests() async {
    final idt1 = Uuid().v1().toString();
    final idt2 = Uuid().v1().toString();
    final idt3 = Uuid().v1().toString();

    final idq1 = Uuid().v1().toString();
    final idq2 = Uuid().v1().toString();
    final idq3 = Uuid().v1().toString();
    final idq4 = Uuid().v1().toString();
    final question1 = TestQuestion(
        id: idq1, image: null, text: "В каком году была разработана Java?");
    final question2 =
        TestQuestion(id: idq2, image: null, text: "Что такое JDK?");
    final question3 =
        TestQuestion(id: idq3, image: null, text: "Что такое JRE?");
    final question4 = TestQuestion(
        id: idq4, image: null, text: "Популярная среда разработки для Java:");
    final qa = <TestQuestion>[question1, question2, question3, question4];

    final ida1 = Uuid().v1().toString();
    final ida2 = Uuid().v1().toString();
    final ida3 = Uuid().v1().toString();
    final answer1 = TestAnswer(id: ida1, text: "1996", isRight: true);
    final answer2 = TestAnswer(id: ida2, text: "1990", isRight: false);
    final answer3 = TestAnswer(id: ida3, text: "1995", isRight: false);

    final ida4 = Uuid().v1().toString();
    final ida5 = Uuid().v1().toString();
    final ida6 = Uuid().v1().toString();
    final answer4 =
        TestAnswer(id: ida4, text: "java development kit", isRight: true);
    final answer5 =
        TestAnswer(id: ida5, text: "java deployment kit", isRight: false);
    final answer6 =
        TestAnswer(id: ida6, text: "java distributed kit", isRight: false);

    final ida7 = Uuid().v1().toString();
    final ida8 = Uuid().v1().toString();
    final ida9 = Uuid().v1().toString();
    final answer7 =
        TestAnswer(id: ida7, text: "java runtime exception", isRight: false);
    final answer8 =
        TestAnswer(id: ida8, text: "java runtime environment", isRight: true);
    final answer9 =
        TestAnswer(id: ida9, text: "java runtime execution", isRight: false);

    final ida10 = Uuid().v1().toString();
    final ida11 = Uuid().v1().toString();
    final ida12 = Uuid().v1().toString();
    final answer10 = TestAnswer(id: ida10, text: "PyCharm", isRight: false);
    final answer11 = TestAnswer(id: ida11, text: "Блокнот", isRight: false);
    final answer12 =
        TestAnswer(id: ida12, text: "IntelliJ IDEA", isRight: true);
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
    final a4 = <TestAnswer>[answer10, answer11, answer12];

    final questionBox = await BoxManager.instance.openQuestionsBox(idt1);

    final answerBox1 = await BoxManager.instance.openAnswersBox(idq1);
    await answerBox1.addAll(a1);
    await BoxManager.instance.closeBox(answerBox1);

    final answerBox2 = await BoxManager.instance.openAnswersBox(idq2);
    await answerBox2.addAll(a2);
    await BoxManager.instance.closeBox(answerBox2);

    final answerBox3 = await BoxManager.instance.openAnswersBox(idq3);
    await answerBox3.addAll(a3);
    await BoxManager.instance.closeBox(answerBox3);

    final answerBox4 = await BoxManager.instance.openAnswersBox(idq4);
    await answerBox4.addAll(a4);
    await BoxManager.instance.closeBox(answerBox4);

    await questionBox.addAll(qa);
    await BoxManager.instance.closeBox(questionBox);

    question1.answers = HiveList(answerBox1);
    question2.answers = HiveList(answerBox2);
    question3.answers = HiveList(answerBox3);
    question4.answers = HiveList(answerBox4);

    final test1 = Test(
        id: idt1,
        name: "Тест 1. Введение в Java.",
        image:
            "https://changellenge.com/upload/iblock/8fb/8fbfea7d04945d7c47c62d0617866ff7.jpg",
        text: "Текст",
        questionsCount: 4);
    test1.questions = HiveList(questionBox);

    final list = <Test>[test1];
    return list;
  }
}
