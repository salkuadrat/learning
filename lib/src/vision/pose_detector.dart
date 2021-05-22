import '../model/model.dart';
import '../shared.dart';

class PoseDetector {
  PoseDetector();

  Future detect(InputImage image) async {}

  Future dispose() async {
    await channel.invokeMethod('disposePoseDetection');
  }
}
