import '../model/model.dart';
import '../shared.dart';

class ImageLabeling {
  ImageLabeling();

  Future process(InputImage image) async {}

  Future dispose() async {
    await channel.invokeMethod('disposeImageLabeling');
  }
}
