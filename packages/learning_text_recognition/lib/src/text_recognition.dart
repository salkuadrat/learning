import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'options.dart';
import 'text.dart';

class TextRecognition {
  final MethodChannel channel = MethodChannel('LearningTextRecognition');
  final TextRecognitionOptions options;

  TextRecognition({this.options = TextRecognitionOptions.Default});

  Future<RecognizedText?> process(InputImage image) async {
    try {
      final result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'options': fromOptions(options),
      });

      if (result != null) {
        return RecognizedText.from(result);
      }
    } on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
