import 'package:app_learn/factories/screen_factory.dart';
import 'package:app_learn/ui/screens/main_screen.dart';
import 'package:app_learn/ui/screens/video_viewer_screen.dart';
import 'package:flutter/material.dart';

/// Названия маршрутов навигации
abstract class MainNavigationRoutesNames {
  static const loaderScreen = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const lectureDetail = '/main_screen/lecture_details_screen';
  static const testDetail = '/main_screen/test_details_screen';
  static const lectureVideo =
      '/main_screen/lecture_details_screen/lecture_video';
}

/// Навигация
class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.loaderScreen: (_) => _screenFactory.makeLoader(),
    MainNavigationRoutesNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRoutesNames.mainScreen: (context) => const MainScreen(),
  };

  Route<Object> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.lectureDetail:
        final arguments = settings.arguments;
        final lectureId = arguments is String ? arguments : "";
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeLectureDetail(lectureId));
      case MainNavigationRoutesNames.testDetail:
        final arguments = settings.arguments;
        final testId = arguments is String ? arguments : "";
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeTestDetail(testId));
      case MainNavigationRoutesNames.lectureVideo:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (_) => ViderViewerScreen(youTubeKey: youTubeKey));
      default:
        return MaterialPageRoute(
            builder: ((_) => const Center(child: Text('Navigation error'))));
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRoutesNames.loaderScreen, (route) => false);
  }
}
