import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'shared.dart';

class BarcodeScanner {
  final MethodChannel channel = MethodChannel('LearningBarcodeScanning');
  final List<BarcodeFormat> formats;

  BarcodeScanner({this.formats = const []});

  Future<List<Map<String, dynamic>>> scan(InputImage image) async {
    List<Map<String, dynamic>> result = [];

    try {
      result = await channel.invokeMethod('scan', <String, dynamic>{
        'image': image.json,
        'formats': formatsToString(formats),
      });
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
