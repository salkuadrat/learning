import 'package:flutter/services.dart';
import 'package:learning_input_image/learning_input_image.dart';

import 'label.dart';

class ImageLabeling {
  final MethodChannel channel = MethodChannel('LearningImageLabeling');
  final double confidenceThreshold;

  ImageLabeling({this.confidenceThreshold = 0.8});

  Future<List<Label>> process(InputImage image) async {
    try {
      List labels = await channel.invokeMethod('process', <String, dynamic>{
        'image': image.json,
        'confidenceThreshold': confidenceThreshold,
      });

      return labels.map((label) => Label.from(label)).toList();
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future dispose() async {
    await channel.invokeMethod('dispose');
  }
}
