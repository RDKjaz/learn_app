import 'dart:async';

import 'package:app_learn/entities/tests.dart';
import 'package:app_learn/ui/theme/text_styles.dart';
import 'package:app_learn/ui/widgets/test_detail/test_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestDetail extends StatefulWidget {
  const TestDetail({super.key});

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  final pageController = PageController(initialPage: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(
      () => context.read<TestDetailViewModel>().setup(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1),
        child: _DescriptionWidget(pageController: pageController),
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
        context.select((TestDetailViewModel model) => model.data.name);
    return Text(title);
  }
}

class _DescriptionWidget extends StatefulWidget {
  _DescriptionWidget({super.key, required this.pageController});

  final PageController pageController;
  bool isButtonColorChanged = false;
  var res = 0;
  Timer? colorChangeTimer;

  @override
  State<_DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  void checkAnswer(TestAnswer a) {
    if (a.isRight) {
      widget.pageController.nextPage(
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
      widget.res++;
    } else {
      widget.pageController.nextPage(
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    }
  }

  Future<void> _showAlertDialog(int res, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Тест завершен'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Правильных ответов - $res"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ОК'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void end(TestDetailViewModel model, TestAnswer a) async {
    if (a.isRight) {
      widget.res++;
    }
    await model.saveResult(widget.res);
    await _showAlertDialog(widget.res, context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final questionsCount = context
        .select((TestDetailViewModel model) => model.data.questionsCount);
    final model = context.watch<TestDetailViewModel>();
    var widgets = <Widget>[];
    var questions = model.data.questions;
    var answers = model.data.answers;
    for (int i = 0; i < questions.length; i++) {
      var q = questions[i];
      final k = Column(
        children: [
          Text("${i + 1}. " + q.text, style: AnswerTextStyle.style),
          ElevatedButton(
              onPressed: () => i != questions.length - 1
                  ? checkAnswer(answers[q.id]![0])
                  : end(model, answers[q.id]![0]),
              child: Text(
                answers[q.id]![0].text,
                style: AnswerTextStyle.style,
              )),
          ElevatedButton(
              onPressed: () => i != questions.length - 1
                  ? checkAnswer(answers[q.id]![1])
                  : end(model, answers[q.id]![1]),
              child: Text(
                answers[q.id]![1].text,
                style: AnswerTextStyle.style,
              )),
          ElevatedButton(
              onPressed: () => i != questions.length - 1
                  ? checkAnswer(answers[q.id]![2])
                  : end(model, answers[q.id]![2]),
              child: Text(
                answers[q.id]![2].text,
                style: AnswerTextStyle.style,
              )),
        ],
      );
      widgets.add(k);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            // physics: const NeverScrollableScrollPhysics(),
            controller: widget.pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int page) {
              setState(() {});
            },
            children: widgets.toList(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PageArrows(
          pageController: widget.pageController,
          lastPageNumber: widgets.length,
        )
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: index != 1 ? Colors.white : Colors.grey[800],
        //   ),
        //   onPressed: index != 1
        //       ? () {
        //           widget.pageController.previousPage(
        //               duration: const Duration(milliseconds: 700),
        //               curve: Curves.easeInOut);
        //           index--;
        //         }
        //       : () {},
        // ),
        // IconButton(
        //   icon: Icon(
        //     Icons.arrow_forward,
        //     color: index != widget.lastPageNumber
        //         ? Colors.white
        //         : Colors.grey[800],
        //   ),
        //   onPressed: index != widget.lastPageNumber
        //       ? () {
        //           widget.pageController.nextPage(
        //               duration: const Duration(milliseconds: 700),
        //               curve: Curves.easeInOut);
        //           index++;
        //         }
        //       : () {},
        // ),
      ],
    );
  }
}
