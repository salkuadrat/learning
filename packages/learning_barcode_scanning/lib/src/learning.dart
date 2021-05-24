/* import 'package:learning_input_image/learning_input_image.dart';
import 'shared.dart';
import 'scanner.dart';

class MLBarcodeScanning {
  Future<List<Map<String, dynamic>>> process(InputImage image,
      {List<BarcodeFormat> formats = const []}) async {
    BarcodeScanner scanner = BarcodeScanner(formats: formats);
    var result = await scanner.scan(image);
    scanner.dispose();
    return result;
  }
}
 */
