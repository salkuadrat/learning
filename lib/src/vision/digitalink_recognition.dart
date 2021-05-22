import '../model/model.dart';
import '../shared.dart';

class DigitalInkRecognition {
  
  DigitalInkRecognition();

  Future process(InputImage image) async {
    
  }

  Future dispose() async {
    await channel.invokeMethod('disposeDigitalInkRecognition');
  }
}