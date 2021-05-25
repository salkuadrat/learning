import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'face.dart';

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;

  final bool boundFill;
  final bool boundStroke;
  final Color? boundFillColor;
  final Color? boundStrokeColor;
  final double boundStrokeWidth;

  final bool paintLandmark;
  final double landmarkRadius;
  final Color? landmarkColor;

  final bool paintContour;
  final double contourStrokeWidth;
  final Color? contourColor;

  const FacePainter({
    this.faces = const [],
    required this.imageSize,
    required this.rotation,
    this.boundFill = false,
    this.boundStroke = true,
    this.boundFillColor,
    this.boundStrokeColor,
    this.boundStrokeWidth = 1.0,
    this.paintLandmark = true,
    this.landmarkRadius = 2.0,
    this.landmarkColor,
    this.paintContour = true,
    this.contourStrokeWidth = 0.8,
    this.contourColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (faces.isEmpty) {
      return;
    }

    for (Face face in faces) {
      _paintFace(face, canvas, size);
    }
  }

  void _paintFace(Face face, Canvas canvas, Size size) {
    if (paintLandmark && landmarkColor != null) {
      for (FaceLandmarkType type in face.landmarks.keys) {
        FaceLandmark? landmark = face.landmarks[type];

        if (landmark != null) {
          _paintLandmark(landmark.point, canvas, size);
        }
      }
    }

    if (paintContour && contourColor != null) {
      for (FaceContourType type in face.countours.keys) {
        FaceContour? contour = face.countours[type];

        if (contour != null) {
          _paintContour(contour.points, canvas, size);
        }
      }
    }

    _paintBoundingBox(
      Rect.fromLTRB(
        transformX(face.boundingBox.left, size),
        transformY(face.boundingBox.top, size),
        transformX(face.boundingBox.right, size),
        transformY(face.boundingBox.bottom, size),
      ),
      canvas,
    );
  }

  void _paintLandmark(Offset point, Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = landmarkColor!;

    canvas.drawCircle(transform(point, size), landmarkRadius, paint);
  }

  void _paintContour(List<Offset> points, Canvas canvas, Size size) {
    _paintContourLine(points, canvas, size);
    /* for (Offset point in points) {
      _paintContourDot(point, canvas);
    } */
  }

  /* void _paintContourDot(Offset point, Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = contourColor!;

    canvas.drawCircle(
      Offset(
        transformX(point.dx),
        transformY(point.dy),
      ),
      contourDotRadius,
      paint,
    );
  } */

  void _paintContourLine(List<Offset> points, Canvas canvas, Size size) {
    final path = Path()..fillType = PathFillType.evenOdd;
    final start = points.first;

    final paint = Paint()
      ..color = contourColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = contourStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.srcOver;

    path.moveTo(
      transformX(start.dx, size),
      transformY(start.dy, size),
    );

    for (var i = 1; i < points.length; i++) {
      path.lineTo(
        transformX(points[i].dx, size),
        transformY(points[i].dy, size),
      );
    }

    canvas.drawPath(path, paint);
  }

  void _paintBoundingBox(Rect rect, Canvas canvas) {
    List<Offset> points = [
      rect.topLeft,
      rect.topRight,
      rect.bottomRight,
      rect.bottomLeft,
    ];

    if (boundStroke) {
      _paintBoundingBoxStroke(points, canvas);
    }

    if (boundFill) {
      _paintBoundingBoxFill(points, canvas);
    }
  }

  void _paintBoundingBoxStroke(List<Offset> points, Canvas canvas) {
    final paint = Paint()
      ..color = boundStrokeColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = boundStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.srcOver;

    final path = Path();
    final start = points.first;

    path.moveTo(start.dx, start.dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  void _paintBoundingBoxFill(List<Offset> points, Canvas canvas) {
    final paint = Paint()
      ..color = boundFillColor!
      ..style = PaintingStyle.fill;

    final path = Path();
    path.addPolygon(points, true);
    canvas.drawPath(path, paint);
  }

  Offset transform(Offset point, Size size) {
    return Offset(transformX(point.dx, size), transformY(point.dy, size));
  }

  double transformX(double x, Size size) {
    switch (rotation) {
      case InputImageRotation.ROTATION_90:
        return x * size.width / imageSize.height;
      case InputImageRotation.ROTATION_270:
        return size.width - x * size.width / imageSize.height;
      default:
        return x * size.width / imageSize.width;
    }
  }

  double transformY(double y, Size size) {
    switch (rotation) {
      case InputImageRotation.ROTATION_90:
      case InputImageRotation.ROTATION_270:
        return y * size.height / imageSize.width;
      default:
        return y * size.height / imageSize.height;
    }
  }

  @override
  bool shouldRepaint(FacePainter oldPainter) {
    return oldPainter.faces != faces;
  }
}
