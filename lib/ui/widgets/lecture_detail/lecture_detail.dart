import 'dart:io';

import 'package:app_learn/navigation/main_navigation.dart';
import 'package:app_learn/ui/widgets/lecture_detail/lecture_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LectureDetail extends StatefulWidget {
  const LectureDetail({super.key});

  @override
  State<LectureDetail> createState() => _LectureDetailState();
}

class _LectureDetailState extends State<LectureDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(
      () => context.read<LectureDetailViewModel>().setup(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1),
        child: _AdditionalInfoWidget(),
      ),
    );
  }
}

/// Название лекции
class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final title =
        context.select((LectureDetailViewModel model) => model.data.name);
    return Text(title);
  }
}

/// Дополнительная информация
class _AdditionalInfoWidget extends StatelessWidget {
  const _AdditionalInfoWidget();
  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LectureDetailViewModel model) => model.data.isLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [const _LectureInfoWidget(), _LectureTextWidget()],
    );
  }
}

/// Изображение
class _ImageWidget extends StatelessWidget {
  const _ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final image =
        context.select((LectureDetailViewModel model) => model.data.image);
    return image != null
        ? AspectRatio(
            aspectRatio: 390 / 219,
            child: Stack(
              children: [
                Center(
                  child: Image.network(image),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

/// Информации лекции
class _LectureInfoWidget extends StatelessWidget {
  const _LectureInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImageWidget(),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PlayVideoWidget(),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Текст лекции',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Видео виджет
class _PlayVideoWidget extends StatelessWidget {
  const _PlayVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final youTubeKey =
        context.select((LectureDetailViewModel model) => model.data.videoUrl);
    return youTubeKey != null
        ? TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
                MainNavigationRoutesNames.lectureVideo,
                arguments: youTubeKey),
            child: const Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.white),
                Text('Смотреть видео', style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

/// Текст лекции и постраничное чтение
class _LectureTextWidget extends StatefulWidget {
  _LectureTextWidget({super.key});

  late PageController pageController;

  @override
  State<_LectureTextWidget> createState() => _LectureTextWidgetState();
}

class _LectureTextWidgetState extends State<_LectureTextWidget> {
  @override
  void didChangeDependencies() {
    final page = context.read<LectureDetailViewModel>().data.currentPage;
    widget.pageController = PageController(initialPage: page);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LectureDetailViewModel>();

    final overview =
        context.select((LectureDetailViewModel model) => model.data.text);
    List<String> substrings = [];

    for (int i = 0; i < overview.length; i += 700) {
      if (i + 700 <= overview.length) {
        substrings.add(overview.substring(i, i + 700));
      } else {
        substrings.add(overview.substring(i));
      }
    }

    final texts = substrings.map(
      (e) => Text(
        e,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    var links = <Widget>[];
    if (model.data.links != null && model.data.links!.isNotEmpty) {
      for (var i = 0; i < model.data.links!.length; i++) {
        final link = model.data.links![i];
        final w = ElevatedButton(
            onPressed: () => launchUrlString(link),
            child: Text("Ссылка ${i + 1}"));
        links.add(w);
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 360,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: widget.pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int page) {
              setState(() {});
            },
            children: texts.toList(),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        PageArrows(
          pageController: widget.pageController,
          lastPageNumber: substrings.length,
        ),
        SizedBox(height: 20),
        Column(children: links),
      ],
    );
  }
}

class PageArrows extends StatefulWidget {
  const PageArrows({
    super.key,
    required this.pageController,
    required this.lastPageNumber,
  });

  final PageController pageController;
  final int lastPageNumber;

  @override
  State<PageArrows> createState() => _PageArrowsState();
}

class _PageArrowsState extends State<PageArrows> {
  var index = 1;

  @override
  Widget build(BuildContext context) {
    final model = context.read<LectureDetailViewModel>();
    final page = context
        .select((LectureDetailViewModel model) => model.data.currentPage);
    index = page;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: index + 1 != 1 ? Colors.white : Colors.grey[800],
          ),
          onPressed: index + 1 != 1
              ? () {
                  widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut);
                  index--;
                  model.data.currentPage = index;
                  model.savePage(context);
                }
              : () {},
        ),
        Text(
          "${index + 1}/${widget.lastPageNumber} стр.",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward,
            color: index + 1 != widget.lastPageNumber
                ? Colors.white
                : Colors.grey[800],
          ),
          onPressed: index + 1 != widget.lastPageNumber
              ? () {
                  widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut);
                  index++;
                  model.data.currentPage = index;
                  model.savePage(context);
                }
              : () {},
        ),
      ],
    );
  }
}
