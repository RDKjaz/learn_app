import 'package:app_learn/ui/widgets/others/radial_percent_widget.dart';
import 'package:app_learn/ui/widgets/test_list/test_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TestListViewModel>().setup(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _TestListWidget(),
      ],
    );
  }
}

class _TestListWidget extends StatelessWidget {
  const _TestListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TestListViewModel>();
    return ListView.builder(
      itemCount: model.tests.length,
      itemExtent: 163,
      padding: const EdgeInsets.only(top: 20),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (BuildContext context, int index) =>
          _TestListItemWidget(index: index),
    );
  }
}

class _TestListItemWidget extends StatelessWidget {
  final int index;
  const _TestListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TestListViewModel>();
    final test = model.tests[index];
    final image = test.image;
    model.showedTestAtIndex(index);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Image.network(image, width: 95),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        test.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Результат - ${test.result}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _ScoreWidget(index: index),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => model.onTestTap(context, index),
              splashColor: const Color.fromRGBO(10, 10, 10, 0.05),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Результат виджет
class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final result =
        context.select((TestListViewModel model) => model.tests[index].result);
    final qcount =
        context.select((TestListViewModel model) => model.tests[index].count);
    final res = int.parse(result);
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: RadialPercentWidget(
            percent: (res / qcount) * 100,
            child: Text(
              ((res / qcount) * 100).toStringAsFixed(0) + "%",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Результат',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
