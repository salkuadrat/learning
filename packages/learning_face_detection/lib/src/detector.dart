import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'face.dart';

enum FaceDetectorMode { fast, accurate }

class FaceDetector {
  final MethodChannel channel = MethodChannel('LearningFaceDetection');
  final double minFaceSize;
  final bool detectLandmark;
  final bool detectContour;
  final bool enableClassification;
  final bool enableTracking;
  final FaceDetectorMode mode;

  FaceDetector({
    this.mode = FaceDetectorMode.fast,
    this.minFaceSize = 0.15,
    this.detectLandmark = false,
    this.detectContour = false,
    this.enableClassification = false,
    this.enableTracking = false,
  }) : assert(minFaceSize > 0.0 && minFaceSize <= 1.0);

  Future<List<Face>> detect(InputImage image) async {
    try {
      List result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'minFaceSize': minFaceSize,
        'performance': mode == FaceDetectorMode.accurate ? 'accurate' : 'fast',
        'landmark': detectLandmark ? 'all' : 'none',
        'contour': detectContour ? 'all' : 'none',
        'classification': enableClassification ? 'all' : 'none',
        'enableTracking': enableTracking,
      });

      return result.map((face) => Face.from(face)).toList();
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
