import 'package:flutter/services.dart';
import 'package:learning_input_image/input_image.dart';

class DigitalInkRecognition {
  final MethodChannel channel = MethodChannel('LearningDigitalInkRecognition');

  DigitalInkRecognition();

  Future<List<Map<String, dynamic>>> process(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
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
