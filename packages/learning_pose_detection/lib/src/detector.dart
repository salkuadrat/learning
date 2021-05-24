import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'pose.dart';

class PoseDetector {
  final MethodChannel channel = MethodChannel('LearningPoseDetection');
  final bool isStream;

  PoseDetector({this.isStream = false});

  Future<Pose?> detect(InputImage image) async {
    try {
      Map result = await channel.invokeMethod('detect', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
      });

      return Pose.from(result);
    } on PlatformException catch (e) {
      print(e.message);
    }

    return null;
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
