import '../model/model.dart';
import '../shared.dart';

class SelfieSegmentation {
  
  SelfieSegmentation();

  Future process(InputImage image) async {
    
  }

  Future dispose() async {
    await channel.invokeMethod('disposeSelfieSegmentation');
  }
}