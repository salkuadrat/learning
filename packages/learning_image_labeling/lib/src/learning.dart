/* import 'package:learning_input_image/learning_input_image.dart';

import 'image_labeling.dart';

class MLImageLabeling {
  Future<List<Map<String, dynamic>>> process(InputImage image,
      {double confidenceThreshold = 0.8}) async {
    List<Map<String, dynamic>> result = [];
    ImageLabeling imageLabeling =
        ImageLabeling(confidenceThreshold: confidenceThreshold);
    result = await imageLabeling.process(image);
    imageLabeling.dispose();
    return result;
  }
}
 */
