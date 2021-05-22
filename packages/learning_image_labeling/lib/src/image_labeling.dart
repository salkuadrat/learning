import 'package:flutter/services.dart';
import 'package:learning_input_image/input_image.dart';

class ImageLabeling {
  final MethodChannel channel = MethodChannel('LearningImageLabeling');
  final double confidenceThreshold;

  ImageLabeling({this.confidenceThreshold = 0.8});

  Future<List<Map<String, dynamic>>> process(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'confidenceThreshold': confidenceThreshold,
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
