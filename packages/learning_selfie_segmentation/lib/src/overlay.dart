import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'mask.dart';
import 'painter.dart';

class SegmentationOverlay extends StatelessWidget {
  final SegmentationMask mask;
  final Size size;
  final Size originalSize;
  final Color? color;
  final InputImageRotation? rotation;

  const SegmentationOverlay({
    Key? key,
    required this.mask,
    required this.size,
    required this.originalSize,
    this.rotation,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SegmentationPainter(
        mask: mask,
        size: size,
        imageSize: originalSize,
        rotation: rotation ?? InputImageRotation.ROTATION_0,
        color: color ?? Colors.purple,
      ),
      child: Container(
        width: size.width,
        height: size.height,
      ),
    );
  }
}
