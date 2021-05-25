import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'face.dart';
import 'painter.dart';

class FaceOverlay extends StatelessWidget {
  final List<Face> faces;
  final Size size;
  final Size? originalSize;
  final Color? landmarkColor;
  final Color? contourColor;
  final Color? boundStrokeColor;
  final InputImageRotation? rotation;

  const FaceOverlay({
    Key? key,
    required this.size,
    this.originalSize,
    this.rotation,
    this.faces = const [],
    this.landmarkColor,
    this.contourColor,
    this.boundStrokeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FacePainter(
        faces: faces,
        imageSize: originalSize ?? size,
        rotation: rotation ?? InputImageRotation.ROTATION_0,
        landmarkColor: landmarkColor ?? Colors.red,
        contourColor: contourColor ?? Theme.of(context).primaryColor,
        boundStrokeColor: boundStrokeColor ?? Colors.red,
      ),
      child: Container(
        width: size.width,
        height: size.height,
      ),
    );
  }
}
