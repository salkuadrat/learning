import '../model/model.dart';
import '../shared.dart';

class FaceDetector {
  
  FaceDetector();

  Future detect(InputImage image) async {
    
  }

  Future dispose() async {
    await channel.invokeMethod('disposeFaceDetection');
  }
}