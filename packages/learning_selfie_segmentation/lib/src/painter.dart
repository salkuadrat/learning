import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'mask.dart';

class SegmentationPainter extends CustomPainter {
  final SegmentationMask mask;
  final Size size;
  final Size imageSize;
  final Color color;
  final InputImageRotation rotation;

  SegmentationPainter({
    required this.mask,
    required this.size,
    required this.imageSize,
    required this.color,
    this.rotation = InputImageRotation.ROTATION_0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final width = mask.width;
    final height = mask.height;
    final confidences = mask.confidences;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int tx = transformX(x.toDouble(), size).round();
        int ty = transformY(y.toDouble(), size).round();

        double opacity = confidences[(y * width) + x] * 0.25;
        paint..color = color.withOpacity(opacity);
        canvas.drawCircle(Offset(tx.toDouble(), ty.toDouble()), 1, paint);
      }
    }
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
  bool shouldRepaint(SegmentationPainter oldPainter) {
    return oldPainter.mask != mask;
  }
}
