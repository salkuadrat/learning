import 'package:flutter/services.dart';

import '../shared.dart';

class LanguageIdentifier {
  final double confidenceThreshold;

  LanguageIdentifier({this.confidenceThreshold = 0.5});

  Future<String> identifyLanguage(String text) async {
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
      var items = await _identify(text, isMultipleLanguages: true)
          as List<Map<String, dynamic>>?;

      if (items != null) {
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

  Future<dynamic?> _identify(String text,
      {bool isMultipleLanguages = false}) async {
    return await channel
        .invokeMethod('nLanguageIdentification', <String, dynamic>{
      'text': text,
      'isMultipleLanguages': isMultipleLanguages,
      'confidenceThreshold': confidenceThreshold,
    });
  }

  Future dispose() async {
    await channel.invokeMethod('disposeLanguageIdentification');
  }
}

class IdentifiedLanguage {
  final String language;
  final double confidence;

  IdentifiedLanguage(this.language, this.confidence);
}
