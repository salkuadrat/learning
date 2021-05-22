import 'package:flutter/services.dart';
import 'shared.dart';

class EntityExtractor {
  final MethodChannel channel = MethodChannel('LearningEntityExtraction');
  final String model;

  EntityExtractor({this.model = ENGLISH});

  Future<List> extract(String text) async {
    try {
      return await channel.invokeMethod('extract', <String, dynamic>{
        'text': text,
        'model': model,
      });
    } on PlatformException catch (e) {
      print(e.message);
      return [];
    }
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
