import 'package:app_learn/data_providers/box_manager.dart';
import 'package:app_learn/entities/tests.dart';

class TestApiClient {
  /// Получить тесты
  Future<Tests> getTests(String userId) async {
    // var items = <Test>[];
    // for (var i = 0; i < 10; i++) {
    //   var item = Test(
    //       id: i,
    //       name: "Тест Название " + i.toString(),
    //       image:
    //           "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
    //       text: "Описание",
    //       questionsCount: 5);
    //   items.add(item);
    // }
    // var resp = Tests(tests: items, totalResults: items.length);
    final box = await BoxManager.instance.openTestsBox(userId);
    final tests = box.values.toList();
    await BoxManager.instance.closeBox(box);
    return Tests(tests: tests, totalResults: tests.length);
  }

  /// Получить детальную информацию по тестам
  Future<Test> getTest(String userId, String testId) async {
    // var item = Test(
    //     id: testId,
    //     name: "Тест Название " + testId.toString(),
    //     questionsCount: 5,
    //     image:
    //         "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
    //     text:
    //         "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputa");
    // return item;
    final box = await BoxManager.instance.openTestsBox(userId);
    final test = box.values.where((element) => element.id == testId).first;
    await BoxManager.instance.closeBox(box);
    return test;
  }

  /// Находится ли фильм в избранном
  // Future<bool> isFavorite(int movieId, String sessionId) async {
  //   parser(dynamic json) {
  //     final jsonMap = json as Map<String, dynamic>;
  //     return jsonMap['favorite'] as bool;
  //   }

  //   return _networkClient.get(
  //     '/movie/$movieId/account_states',
  //     parser,
  //     {
  //       'api_key': Configuration.apiKey,
  //       'session_id': sessionId,
  //       'movie_id': movieId.toString(),
  //     },
  //   );
  // }
}
