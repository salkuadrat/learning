import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'object.dart';

class ObjectDetector {
  final MethodChannel channel = MethodChannel('LearningObjectDetection');
  final bool isStream;
  final bool enableClassification;
  final bool enableMultipleObjects;

  ObjectDetector({
    this.isStream = false,
    this.enableClassification = true,
    this.enableMultipleObjects = true,
  });

  Future<List<DetectedObject>> detect(InputImage image) async {
    try {
      List result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
        'enableClassification': enableClassification,
        'enableMultipleObjects': enableMultipleObjects,
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
