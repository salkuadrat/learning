/* import 'package:learning_input_image/learning_input_image.dart';

import 'detector.dart';

class MLPoseDetection {
  static Future<List<Map<String, dynamic>>> detect(InputImage image,
      {bool isStream = false}) async {
    PoseDetector detector = PoseDetector(isStream: isStream);
    List<Map<String, dynamic>> result = await detector.detect(image);
    detector.dispose();
    return result;
  }
}
 */
