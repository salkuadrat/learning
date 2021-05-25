import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'object.dart';
import 'painter.dart';

class ObjectOverlay extends StatelessWidget {
  final Size size;
  final Size originalSize;
  final List<DetectedObject> objects;
  final InputImageRotation? rotation;

  ObjectOverlay({
    required this.size,
    required this.originalSize,
    this.objects = const [],
    this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ObjectPainter(
        imageSize: originalSize,
        objects: objects,
        rotation: rotation ?? InputImageRotation.ROTATION_0,
      ),
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
      ),
    );
  }
}
