import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DigitalInkPainter extends CustomPainter {
  final List<List<Offset>> writings;
  final double strokeWidth;
  final Color strokeColor;

  DigitalInkPainter({
    this.writings = const [],
    this.strokeWidth = 2.0,
    this.strokeColor = Colors.black87,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);
    canvas.drawColor(Colors.teal[100]!, BlendMode.multiply);

    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.srcOver;

    for (List<Offset> points in writings) {
      _paintLine(points, canvas, paint);
    }
  }

  void _paintLine(List<Offset> points, Canvas canvas, Paint paint) {
    final start = points.first;
    final path = Path()..fillType = PathFillType.evenOdd;

    path.moveTo(start.dx, start.dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DigitalInkPainter oldPainter) => true;
}
