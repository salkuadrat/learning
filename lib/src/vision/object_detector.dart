import '../model/model.dart';
import '../shared.dart';

class ObjectDetector {
  ObjectDetector();

  Future detect(InputImage image) async {}

  Future dispose() async {
    await channel.invokeMethod('disposeObjectDetection');
  }
}
