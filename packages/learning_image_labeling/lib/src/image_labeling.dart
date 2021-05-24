import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

class ImageLabeling {
  final MethodChannel channel = MethodChannel('LearningImageLabeling');
  final double confidenceThreshold;

  ImageLabeling({this.confidenceThreshold = 0.8});

  Future<List> process(InputImage image) async {
    try {
      List result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'confidenceThreshold': confidenceThreshold,
      });

      return result;
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
