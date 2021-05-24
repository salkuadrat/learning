/* import 'package:learning_input_image/learning_input_image.dart';

import 'detector.dart';

class MLObjectDetection {
  Future<List<Map<String, dynamic>>> detect(
    InputImage image, {
    bool isStream = false,
    bool enableClassification = false,
    bool enableTracking = false,
  }) async {
    ObjectDetector detector = ObjectDetector(
        isStream: isStream,
        enableClassification: enableClassification,
        enableTracking: enableTracking);
    List<Map<String, dynamic>> result = await detector.detect(image);
    detector.dispose();
    return result;
  }
}
 */
