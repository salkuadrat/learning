import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

class PoseDetector {
  final MethodChannel channel = MethodChannel('LearningPoseDetection');
  final bool isStream;

  PoseDetector({this.isStream = false});

  Future<List<Map<String, dynamic>>> detect(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
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
