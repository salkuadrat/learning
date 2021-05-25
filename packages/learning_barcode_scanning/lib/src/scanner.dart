import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'barcode.dart';
import 'shared.dart';

class BarcodeScanner {
  final MethodChannel channel = MethodChannel('LearningBarcodeScanning');
  final List<BarcodeFormat> formats;

  BarcodeScanner({this.formats = const []});

  Future<List> scan(InputImage image) async {
    try {
      List result = await channel.invokeMethod('scan', <String, dynamic>{
        'image': image.json,
        'formats': formatsToString(formats),
      });

      return result.map((barcode) => Barcode.from(barcode)).toList();
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
