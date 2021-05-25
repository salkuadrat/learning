import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'face.dart';
import 'painter.dart';

class FaceOverlay extends StatelessWidget {
  final List<Face> faces;
  final Size size;
  final Size? originalSize;
  final bool? boundFill;
  final bool? boundStroke;
  final bool? paintLandmark;
  final bool? paintContour;
  final Color? landmarkColor;
  final Color? contourColor;
  final Color? boundStrokeColor;
  final double? boundStrokeWidth;
  final double? contourStrokeWidth;
  final double? landmarkRadius;
  final InputImageRotation? rotation;

  const FaceOverlay({
    Key? key,
    required this.size,
    this.originalSize,
    this.rotation,
    this.boundFill,
    this.boundStroke,
    this.paintLandmark,
    this.paintContour,
    this.faces = const [],
    this.landmarkColor,
    this.contourColor,
    this.boundStrokeColor,
    this.boundStrokeWidth,
    this.contourStrokeWidth,
    this.landmarkRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FacePainter(
        faces: faces,
        imageSize: originalSize ?? size,
        rotation: rotation ?? InputImageRotation.ROTATION_0,
        boundFill: boundFill ?? false,
        boundStroke: boundStroke ?? true,
        paintLandmark: paintLandmark ?? true,
        paintContour: paintContour ?? true,
        landmarkColor: landmarkColor ?? Colors.red,
        contourColor: contourColor ?? Theme.of(context).primaryColor,
        boundStrokeColor: boundStrokeColor ?? Colors.red,
        boundStrokeWidth: boundStrokeWidth ?? 1.0,
        contourStrokeWidth: contourStrokeWidth ?? 0.8,
        landmarkRadius: landmarkRadius ?? 2.0,
      ),
      child: Container(
        width: size.width,
        height: size.height,
      ),
    );
  }
}
