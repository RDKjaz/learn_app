import 'package:app_learn/data_providers/box_manager.dart';
import 'package:app_learn/entities/lectures.dart';

class LectureApiClient {
  // final _networkClient = NetworkClient();

  /// Получить лекции
  Future<Lectures> getLectures(String userId) async {
    // var items = <Lecture>[];
    // for (var i = 0; i < 10; i++) {
    //   var item = Lecture(
    //       id: i,
    //       name: "Название " + i.toString(),
    //       image:
    //           "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
    //       text: "Описание",);
    //   items.add(item);
    // }
    // var resp = Lectures(lectures: items, totalResults: items.length);
    final box = await BoxManager.instance.openLecturesBox(userId);
    final lectures = box.values.toList();
    await BoxManager.instance.closeBox(box);
    return Lectures(lectures: lectures, totalResults: lectures.length);
  }

  /// Получить детальную информацию по лекции
  Future<Lecture> getLecture(String userId, String lectureId) async {
    // var item = Lecture(
    //     currentPage: 0,
    //     isFinished: false,
    //     id: lectureId.toString(),
    //     name: "Название " + lectureId.toString(),
    //     image:
    //         "https://upload.wikimedia.org/wikipedia/commons/1/1b/%D0%98%D0%B7%D0%BE%D0%B1%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_307.jpg",
    //     text:
    //         "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputa");
    // return item;

    final box = await BoxManager.instance.openLecturesBox(userId);
    final lecture =
        box.values.where((element) => element.id == lectureId).first;
    await BoxManager.instance.closeBox(box);
    return lecture;
  }

  /// Сохранить страницу
  Future<void> savePage(int page, String userId, String lectureId) async {
    final box = await BoxManager.instance.openLecturesBox(userId);
    final lecture =
        box.values.where((element) => element.id == lectureId).first;
    lecture.currentPage = page;
    await lecture.save();
    await BoxManager.instance.closeBox(box);
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
