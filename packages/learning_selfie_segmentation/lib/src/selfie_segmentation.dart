import 'package:flutter/services.dart';
import 'package:learning_input_image/input_image.dart';

class SelfieSegmentation {
  final MethodChannel channel = MethodChannel('LearningSelfieSegmentation');
  final bool isStream;
  final bool enableRawSizeMask;

  SelfieSegmentation({
    this.isStream = false,
    this.enableRawSizeMask = false,
  });

  Future<List<Map<String, dynamic>>> process(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
        'enableRawSizeMask': enableRawSizeMask,
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
