import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CirclePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final bool? stroke;
  final Color? strokeColor;
  final double? strokeOpacity;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final bool? fill;
  final Color? fillColor;
  final double? fillOpacity;

  CirclePainter({
    required this.center,
    this.radius = 0.0,
    this.stroke,
    this.strokeColor,
    this.strokeOpacity,
    this.strokeWidth,
    this.strokeCap,
    this.strokeJoin,
    this.fill,
    this.fillColor,
    this.fillOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    // always check for strokeWidth and strokeColor before painting the stroke
    final isPaintStroke =
        stroke! && (strokeWidth! > 0) && (strokeColor != null);
    final isPaintFill = fill! && (fillColor != null);

    if (isPaintStroke) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = strokeColor!.withOpacity(strokeOpacity!)
        ..strokeCap = strokeCap!
        ..strokeJoin = strokeJoin!
        ..strokeWidth = strokeWidth!;

      canvas.drawCircle(center, radius, paint);
    }

    if (isPaintFill) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = fillColor!.withOpacity(fillOpacity!);

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldCircle) => false;
}

class PolylinePainter extends CustomPainter {
  final List<Offset> points;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final PathFillType? pathFillType;
  final bool? isDotted;
  final bool? culling;

  PolylinePainter({
    this.points = const [],
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.pathFillType,
    this.isDotted,
    this.culling,
  });

  bool get hasPoints => points.isNotEmpty;
  bool get noPoints => !hasPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (noPoints) {
      return;
    }

    final radius = strokeWidth! / 2;
    final spacing = strokeWidth! * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..strokeJoin = strokeJoin!
      ..blendMode = BlendMode.srcOver;

    paint.color = strokeColor!.withOpacity(strokeOpacity!);

    canvas.saveLayer(rect, paint);

    if (isDotted!) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, radius, spacing, paint);
    } else {
      _paintLine(canvas, paint);
    }

    canvas.restore();
  }

  void _paintLine(Canvas canvas, Paint paint) {
    final start = points.first;
    final path = Path()..fillType = pathFillType!;

    path.moveTo(start.dx, start.dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _paintDottedLine(
      Canvas canvas, double radius, double stepLength, Paint paint) {
    num startDistance = 0.0;
    final path = Path()..fillType = pathFillType!;

    for (var i = 0; i < points.length - 1; i++) {
      var current = points[i];
      var next = points[i + 1];
      var totalDistance = _distance(current, next);
      var distance = startDistance;

      while (distance < totalDistance) {
        var f1 = distance / totalDistance;
        var f0 = 1.0 - f1;

        var offset = Offset(
          current.dx * f0 + next.dx * f1,
          current.dy * f0 + next.dy * f1,
        );

        path.addOval(Rect.fromCircle(center: offset, radius: radius));
        distance += stepLength;
      }

      startDistance = distance < totalDistance
          ? stepLength - (totalDistance - distance)
          : distance - totalDistance;
    }

    path.addOval(Rect.fromCircle(center: points.last, radius: radius));
    canvas.drawPath(path, paint);
  }

  // pure trigonometry to calculate distance between a and b
  double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PolygonPainter extends CustomPainter {
  final List<Offset> points;
  final List<List<Offset>> holesPoints;

  final bool? culling;
  final bool? stroke;
  final bool? isDotted;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final PathFillType? pathFillType;
  final Color? fillColor;
  final double? fillOpacity;

  PolygonPainter({
    this.points = const [],
    this.holesPoints = const [],
    this.culling,
    this.stroke,
    this.isDotted,
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.pathFillType,
    this.fillColor,
    this.fillOpacity,
  });

  bool get hasPoints => points.isNotEmpty;
  bool get noPoints => !hasPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (noPoints) {
      return;
    }

    final isPaintStroke =
        stroke! && (strokeWidth! > 0) && (strokeColor != null);
    final isPaintHoles = holesPoints is List && holesPoints.length > 0;

    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = fillColor!.withOpacity(fillOpacity ?? 1.0);

    if (isPaintHoles) {
      canvas.saveLayer(rect, paint);

      for (final hole in holesPoints) {
        final path = Path();
        path.addPolygon(hole, true);
        canvas.drawPath(path, paint);
      }

      paint.blendMode = BlendMode.srcOut;

      final path = Path();
      path.addPolygon(points, true);
      canvas.drawPath(path, paint);

      if (isPaintStroke) {
        _paintStroke(canvas);
      }

      canvas.restore();
    } else {
      final path = Path();
      path.addPolygon(points, true);
      canvas.drawPath(path, paint);

      if (isPaintStroke) {
        _paintStroke(canvas);
      }
    }
  }

  void _paintStroke(Canvas canvas) {
    final radius = strokeWidth! / 2;
    final spacing = strokeWidth! * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..strokeJoin = strokeJoin!
      ..blendMode = BlendMode.srcOver;

    paint.color = strokeColor!.withOpacity(strokeOpacity ?? 1.0);

    if (isDotted!) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, points, radius, spacing, paint);
    } else {
      _paintLine(canvas, points, paint);
    }
  }

  void _paintLine(Canvas canvas, List<Offset>? points, Paint paint) {
    if (points != null && points.isNotEmpty) {
      final path = Path();
      final start = points.first;

      path.moveTo(start.dx, start.dy);

      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _paintDottedLine(Canvas canvas, List<Offset> points, double radius,
      double stepLength, Paint paint) {
    final path = Path();

    double startDistance = 0.0;
    points = [points.first, ...points];

    for (var i = 0; i < points.length - 1; i++) {
      var current = points[i];
      var next = points[i + 1];
      var totalDistance = _distance(current, next);
      var distance = startDistance;

      while (distance < totalDistance) {
        var f1 = distance / totalDistance;
        var f0 = 1.0 - f1;

        var offset = Offset(
          current.dx * f0 + next.dx * f1,
          current.dy * f0 + next.dy * f1,
        );

        path.addOval(Rect.fromCircle(center: offset, radius: radius));
        distance += stepLength;
      }

      startDistance = distance < totalDistance
          ? stepLength - (totalDistance - distance)
          : distance - totalDistance;
    }

    path.addOval(Rect.fromCircle(center: points.last, radius: radius));
    canvas.drawPath(path, paint);
  }

  // pure trigonometry to calculate distance between a and b
  double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  bool shouldRepaint(PolygonPainter oldPainter) => false;
}
