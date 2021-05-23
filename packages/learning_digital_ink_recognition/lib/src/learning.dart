import 'package:learning_input_image/learning_input_image.dart';

import 'digital_ink_recognition.dart';

class MLDigitalInkRecognition {
  static Future<List<Map<String, dynamic>>> process(InputImage image) async {
    DigitalInkRecognition digitalInkRecognition = DigitalInkRecognition();
    List<Map<String, dynamic>> result =
        await digitalInkRecognition.process(image);
    digitalInkRecognition.dispose();
    return result;
  }
}
