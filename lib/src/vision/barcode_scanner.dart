import '../model/model.dart';
import '../shared.dart';

class BarcodeScanner {
  
  BarcodeScanner();

  Future scan(InputImage image) async {
    
  }

  Future dispose() async {
    await channel.invokeMethod('disposeBarcodeScanning');
  }
}