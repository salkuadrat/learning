import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'mask.dart';

class SelfieSegmenter {
  final MethodChannel channel = MethodChannel('LearningSelfieSegmentation');
  final bool isStream;
  final bool enableRawSizeMask;

  SelfieSegmenter({
    this.isStream = true,
    this.enableRawSizeMask = false,
  });

  Future<SegmentationMask?> process(InputImage image) async {
    try {
      Map result = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'isStream': isStream,
        'enableRawSizeMask': enableRawSizeMask,
      });

      return SegmentationMask.from(result);
    } on PlatformException catch (e) {
      print(e.message);
    }

    return null;
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
