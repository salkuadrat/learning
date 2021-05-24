import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'painter.dart';
import 'pose.dart';

class PoseOverlay extends StatelessWidget {
  final Pose pose;
  final Size size;
  final Size? originalSize;
  final InputImageRotation rotation;
  final Color? color;

  const PoseOverlay({
    Key? key,
    required this.pose,
    required this.size,
    this.originalSize,
    this.rotation = InputImageRotation.ROTATION_0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PosePainter(
        pose: pose,
        imageSize: originalSize ?? size,
        rotation: rotation,
      ),
      child: Container(
        width: size.width,
        height: size.height,
      ),
    );
  }
}
