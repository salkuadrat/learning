/* import 'package:learning_input_image/learning_input_image.dart';

import 'selfie_segmentation.dart';

class MLSelfieSegmentation {
  static Future<List<Map<String, dynamic>>> detect(
    InputImage image, {
    bool isStream = false,
    bool enableRawSizeMask = false,
  }) async {
    SelfieSegmentation selfieSegmentation = SelfieSegmentation(
        isStream: isStream, enableRawSizeMask: enableRawSizeMask);
    List<Map<String, dynamic>> result = await selfieSegmentation.process(image);
    selfieSegmentation.dispose();
    return result;
  }
}
 */
