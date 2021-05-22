import '../model/model.dart';
import '../shared.dart';

class TextRecognition {
  TextRecognition();

  Future process(InputImage image) async {}

  Future dispose() async {
    await channel.invokeMethod('disposeTextRecognition');
  }
}
