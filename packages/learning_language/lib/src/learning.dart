/* import 'dart:async';
import 'identifier.dart';

class MLLanguage {
  static Future<String> identify(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    String result = await identifier.identify(text);
    identifier.dispose();
    return result;
  }

  static Future<List<IdentifiedLanguage>> identifyPossibleLanguages(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    List<IdentifiedLanguage> result =
        await identifier.idenfityPossibleLanguages(text);
    identifier.dispose();
    return result;
  }
}
 */
