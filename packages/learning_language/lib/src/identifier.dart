import 'package:flutter/services.dart';

import 'model.dart';

class LanguageIdentifier {
  final MethodChannel channel = MethodChannel('LearningLanguage');
  final double confidenceThreshold;

  LanguageIdentifier({this.confidenceThreshold = 0.5});

  Future<String> identify(String text) async {
    try {
      return await _identify(text);
    } on PlatformException catch (e) {
      print(e.message);
      return '';
    }
  }

  Future<List<IdentifiedLanguage>> idenfityPossibleLanguages(
      String text) async {
    List<IdentifiedLanguage> result = [];

    try {
      var items = await _identify(text, isMultipleLanguages: true);

      if (items is List) {
        for (var item in items) {
          String language = item['language'];
          double confidence = item['confidence'] as double;
          result.add(IdentifiedLanguage(language, confidence));
        }
      }
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future _identify(
    String text, {
    bool isMultipleLanguages = false,
  }) async {
    return await channel.invokeMethod('identify', <String, dynamic>{
      'text': text,
      'isMultipleLanguages': isMultipleLanguages,
      'confidenceThreshold': confidenceThreshold,
    });
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
