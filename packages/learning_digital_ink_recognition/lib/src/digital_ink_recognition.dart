import 'dart:ui';

import 'package:flutter/services.dart';

import 'candidate.dart';

class DigitalInkRecognition {
  final MethodChannel channel = MethodChannel('LearningDigitalInkRecognition');
  final String model;

  DigitalInkRecognition({this.model = 'en-US'});

  Offset? _lastPoint;

  Future<void> start({Size? writingArea}) async {
    await channel.invokeMethod('start', <String, dynamic>{
      'language': model,
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
    _lastPoint = point;
    await channel.invokeMethod('actionMove', <String, dynamic>{
      'x': point.dx,
      'y': point.dy,
    });
  }

  Future<void> actionUp() async {
    if (_lastPoint != null) {
      await channel.invokeMethod('actionUp', <String, dynamic>{
        'x': _lastPoint!.dx,
        'y': _lastPoint!.dy,
      });
    }
  }

  Future<List<RecognitionCandidate>> process({String preContext = ''}) async {
    try {
      List result = await channel
          .invokeMethod('process', <String, dynamic>{'preContext': preContext});
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
