import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'object.dart';

class ObjectPainter extends CustomPainter {
  final Size imageSize;
  final List<DetectedObject> objects;
  final InputImageRotation rotation;

  ObjectPainter({
    required this.imageSize,
    this.objects = const [],
    this.rotation = InputImageRotation.ROTATION_0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (objects.isEmpty) {
      return;
    }

    for (DetectedObject object in objects) {
      _paintObject(object, canvas, size);
    }
  }

  void _paintObject(DetectedObject object, Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
        Rect.fromLTRB(
          transformX(object.boundingBox.left, size),
          transformY(object.boundingBox.top, size),
          transformX(object.boundingBox.right, size),
          transformY(object.boundingBox.bottom, size),
        ),
        paint);

    TextSpan span = new TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      text: object.labels.map((label) => label.label).toList().join(', '),
    );
    TextPainter painter = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(
      canvas,
      Offset(
        transformX(object.boundingBox.left, size) + 5.0,
        transformY(object.boundingBox.top, size) + 4.0,
      ),
    );
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
  bool shouldRepaint(ObjectPainter oldPainter) {
    return oldPainter.objects != objects;
  }
}
