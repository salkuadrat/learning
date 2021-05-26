import 'dart:ui';

import 'package:flutter/services.dart';

import 'candidate.dart';

class DigitalInkRecognition {
  final MethodChannel channel = MethodChannel('LearningDigitalInkRecognition');
  final String language;

  DigitalInkRecognition({
    this.language = 'en-US',
  });

  Future<void> start() async {
    await channel
        .invokeMethod('start', <String, dynamic>{'language': language});
  }

  Future<void> actionDown(Offset point) async {
    await channel.invokeMethod('actionDown', <String, dynamic>{
      'x': point.dx,
      'y': point.dy,
    });
  }

  Future<void> actionMove(Offset point) async {
    await channel.invokeMethod('actionDown', <String, dynamic>{
      'x': point.dx,
      'y': point.dy,
    });
  }

  Future<void> actionUp(Offset point) async {
    await channel.invokeMethod('actionDown', <String, dynamic>{
      'x': point.dx,
      'y': point.dy,
    });
  }

  Future<List<RecognitionCandidate>> process() async {
    try {
      List result = await channel.invokeMethod('process');
      return result.map((item) => RecognitionCandidate.from(item)).toList();
    } on PlatformException catch (e) {
      print(e.message);
    }

    return [];
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
