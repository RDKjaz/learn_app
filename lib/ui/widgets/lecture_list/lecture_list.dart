import 'package:app_learn/ui/widgets/lecture_list/lecture_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureList extends StatefulWidget {
  const LectureList({super.key});

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<LectureListViewModel>().setup(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _LectureListWidget(),
      ],
    );
  }
}

class _LectureListWidget extends StatelessWidget {
  const _LectureListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LectureListViewModel>();
    return ListView.builder(
      itemCount: model.lectures.length,
      itemExtent: 163,
      padding: const EdgeInsets.only(top: 20),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (BuildContext context, int index) =>
          _LectureListItemWidget(index: index),
    );
  }
}

class _LectureListItemWidget extends StatelessWidget {
  final int index;
  const _LectureListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LectureListViewModel>();
    final lecture = model.lectures[index];
    final image = lecture.image;
    model.showedLectureAtIndex(index);
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
                image != null
                    ? Image.network(image, width: 95)
                    : SizedBox(width: 95),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lecture.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 19),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   lecture.name,
                      //   style: TextStyle(
                      //     color: Colors.grey.shade400,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => model.onLectureTap(context, index),
              splashColor: const Color.fromRGBO(10, 10, 10, 0.05),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
