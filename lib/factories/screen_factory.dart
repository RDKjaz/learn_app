import 'package:app_learn/ui/screens/loader_screen.dart';
import 'package:app_learn/ui/screens/main_screen.dart';
import 'package:app_learn/ui/widgets/auth/auth.dart';
import 'package:app_learn/ui/widgets/auth/auth_view_model.dart';
import 'package:app_learn/ui/widgets/lecture_detail/lecture_detail.dart';
import 'package:app_learn/ui/widgets/lecture_detail/lecture_detail_view_model.dart';
import 'package:app_learn/ui/widgets/lecture_list/lecture_list.dart';
import 'package:app_learn/ui/widgets/lecture_list/lecture_list_view_model.dart';
import 'package:app_learn/ui/widgets/test_detail/test_detail.dart';
import 'package:app_learn/ui/widgets/test_detail/test_detail_view_model.dart';
import 'package:app_learn/ui/widgets/test_list/test_list.dart';
import 'package:app_learn/ui/widgets/test_list/test_list_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Фабрика экаранов
class ScreenFactory {
  /// Создать первоначальный экран загрузки
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderScreenViewModel(context),
      lazy: false,
      child: const LoaderScreen(),
    );
  }

  /// Создать экран авторизации
  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const Auth(),
    );
  }

  /// Создать главный экран
  Widget makeMainScreen() {
    return const MainScreen();
  }

  /// Создать экран списка лекций
  Widget makeLectureList() {
    return ChangeNotifierProvider(
      create: (_) => LectureListViewModel(),
      child: const LectureList(),
    );
  }

  /// Создать детальный экран лекции
  Widget makeLectureDetail(String lectureId) {
    return ChangeNotifierProvider(
      create: (_) => LectureDetailViewModel(lectureId),
      child: const LectureDetail(),
    );
  }

  /// Создать экран списка тестов
  Widget makeTestList() {
    return ChangeNotifierProvider(
      create: (_) => TestListViewModel(),
      child: const TestList(),
    );
  }

  /// Создать детальный экран теста
  Widget makeTestDetail(String testId) {
    return ChangeNotifierProvider(
      create: (_) => TestDetailViewModel(testId),
      child: const TestDetail(),
    );
  }
}
