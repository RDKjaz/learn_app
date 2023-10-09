import 'dart:math';

import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double percent;

  const RadialPercentWidget(
      {super.key, required this.child, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: MyPainter(percent: percent)),
        Center(child: child)
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;

  MyPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint();
    backgroundPaint.color = Colors.black;
    canvas.drawOval(Offset.zero & size, backgroundPaint);

    final emptyPaint = Paint();
    emptyPaint.color = Colors.grey;
    emptyPaint.style = PaintingStyle.stroke;
    emptyPaint.strokeWidth = 5;
    canvas.drawArc(Offset(8.5, 8.5) & Size(size.width - 16, size.height - 16),
        3 * pi / 2, -pi * 2 * (1 - percent), false, emptyPaint);

    final fillPaint = Paint();
    fillPaint.color = Colors.green;
    fillPaint.style = PaintingStyle.stroke;
    fillPaint.strokeWidth = 5;
    fillPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(Offset(8.5, 8.5) & Size(size.width - 16, size.height - 16),
        3 * pi / 2, pi * 2 * percent, false, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
