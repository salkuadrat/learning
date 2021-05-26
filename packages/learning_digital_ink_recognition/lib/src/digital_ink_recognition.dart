import 'dart:ui';

import 'package:flutter/services.dart';

import 'candidate.dart';

class DigitalInkRecognition {
  final MethodChannel channel = MethodChannel('LearningDigitalInkRecognition');
  final String language;
  final Size? writingArea;

  DigitalInkRecognition({
    this.language = 'en-US',
    this.writingArea,
  });

  Future<void> start() async {
    await channel.invokeMethod('start', <String, dynamic>{
      'language': language,
      'width': writingArea?.width ?? 0.0,
      'height': writingArea?.height ?? 0.0,
    });
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

  Future<List<RecognitionCandidate>> process({String preContext = ''}) async {
    try {
      List result = await channel.invokeMethod('process', <String, dynamic>{
        'preContext' : preContext
      });
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
