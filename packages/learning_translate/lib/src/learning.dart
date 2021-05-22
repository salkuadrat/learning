/* import 'translator.dart';
import 'manager.dart';

class MLTranslate {
  static Future<String> translate(String text,
      {required String from,
      required String to,
      bool isDownloadRequireWifi = false}) async {
    Translator translator =
        Translator(from, to, isDownloadRequireWifi: isDownloadRequireWifi);
    String result = await translator.translate(text);
    translator.dispose();
    return result;
  }

  static Future<List> listModels() async {
    return await TranslationModelManager.list();
  }

  static Future<bool> downloadModel(String entityModel) async {
    return await TranslationModelManager.download(entityModel);
  }

  static Future<bool> hasModel(String entityModel) async {
    return await TranslationModelManager.check(entityModel);
  }

  static Future<bool> deleteModel(String entityModel) async {
    return await TranslationModelManager.delete(entityModel);
  }
}
 */
