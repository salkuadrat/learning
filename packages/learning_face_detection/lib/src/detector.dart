import 'package:flutter/services.dart';
import 'package:learning_input_image/input_image.dart';

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
  });

  Future<List<Map<String, dynamic>>> detect(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'performance': performance,
        'landmark': landmark,
        'classification': classification,
        'contour': contour,
        'minFaceSize': minFaceSize,
        'enableTracking': enableTracking,
      });
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
