import 'package:learning_input_image/input_image.dart';
import 'detector.dart';

class MLFaceDetection {
  static Future<List<Map<String, dynamic>>> detect(
    InputImage image, {
    String performance = 'fast',
    String landmark = 'none',
    String classification = 'none',
    String contour = 'none',
    double minFaceSize = 0.15,
    bool enableTracking = false,
  }) async {
    FaceDetector detector = FaceDetector(
      performance: performance,
      landmark: landmark,
      classification: classification,
      contour: contour,
      minFaceSize: minFaceSize,
      enableTracking: enableTracking,
    );
    List<Map<String, dynamic>> result = await detector.detect(image);
    detector.dispose();
    return result;
  }
}
