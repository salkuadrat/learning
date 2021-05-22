import 'dart:async';

import 'package:learning_entity_extraction/learning_entity_extraction.dart'
    as LEE;
import 'package:learning_language/learning_language.dart';
import 'package:learning_translate/learning_translate.dart';
import 'package:learning_smart_reply/learning_smart_reply.dart';

class ML {
  static Future<String> identifyLanguage(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    final result = await identifier.identify(text);
    identifier.dispose();
    return result;
  }

  static Future<List<IdentifiedLanguage>> identifyPossibleLanguages(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    final result = await identifier.idenfityPossibleLanguages(text);
    identifier.dispose();
    return result;
  }

  static Future<String> translate(String text,
      {required String from, required String to}) async {
    Translator translator = Translator(from: from, to: to);
    String result = await translator.translate(text);
    translator.dispose();
    return result;
  }

  static Future<List> generateSmartReplies(List<Message> history) async {
    SmartReplyGenerator smartReply = SmartReplyGenerator();
    var result = await smartReply.generateReplies(history);
    smartReply.dispose();
    return result;
  }

  static Future<List> extractEntity(String text,
      {String entityModel = LEE.ENGLISH}) async {
    LEE.EntityExtractor extractor = LEE.EntityExtractor(model: entityModel);
    List result = await extractor.extract(text);
    extractor.dispose();
    return result;
  }
}
