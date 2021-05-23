import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'face.dart';

class FaceDetector {
  final MethodChannel channel = MethodChannel('LearningFaceDetection');
  final String performance;
  final String landmark;
  final String classification;
  final String contour;
  final double minFaceSize;
  final bool enableTracking;

  FaceDetector({
    this.performance = 'fast',
    this.landmark = 'none',
    this.classification = 'none',
    this.contour = 'none',
    this.minFaceSize = 0.15,
    this.enableTracking = false,
  }) : assert(minFaceSize > 0.0 && minFaceSize <= 1.0);

  Future<List<Face>> detect(InputImage image) async {
    List<Face> result = [];

    try {
      List faces = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'performance': performance,
        'landmark': landmark,
        'classification': classification,
        'contour': contour,
        'minFaceSize': minFaceSize,
        'enableTracking': enableTracking,
      });

      for (var face in faces) {
        result.add(Face.from(face));
      }
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
