import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'text.dart';

class TextRecognition {
  final MethodChannel channel = MethodChannel('LearningTextRecognition');

  TextRecognition();

  Future<RecognizedText?> process(InputImage image) async {
    try {
      final result = await channel
          .invokeMethod('process', <String, dynamic>{'image': image.json});

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
