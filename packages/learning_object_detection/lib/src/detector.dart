import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

class ObjectDetector {
  final MethodChannel channel = MethodChannel('LearningObjectDetector');
  final bool isStream;
  final bool enableClassification;
  final bool enableTracking;

  ObjectDetector({
    this.isStream = false,
    this.enableClassification = false,
    this.enableTracking = false,
  });

  Future<List<Map<String, dynamic>>> detect(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
        'enableClassification': enableClassification,
        'enableTracking': enableTracking,
      });
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
