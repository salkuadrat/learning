import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_object_detection/src/model.dart';

class ObjectDetector {
  final MethodChannel channel = MethodChannel('LearningObjectDetection');
  final bool isStream;
  final bool enableClassification;
  final bool enableTracking;

  ObjectDetector({
    this.isStream = false,
    this.enableClassification = false,
    this.enableTracking = false,
  });

  Future<List<DetectedObject>> detect(InputImage image) async {
    try {
      List result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
        'enableClassification': enableClassification,
        'enableTracking': enableTracking,
      });

      return result.map((object) => DetectedObject.from(object)).toList();
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
