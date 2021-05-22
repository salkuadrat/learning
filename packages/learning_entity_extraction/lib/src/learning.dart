/* import 'extractor.dart';
import 'manager.dart';
import 'shared.dart';

class MLEntityExtraction {
  static Future<List> extract(String text,
      {String entityModel = ENGLISH}) async {
    EntityExtractor extractor = EntityExtractor(model: entityModel);
    List result = await extractor.extract(text);
    await extractor.dispose();
    return result;
  }

  static Future<List> listModels() async {
    return await EntityModelManager.list();
  }

  static Future<bool> downloadModel(String entityModel) async {
    return await EntityModelManager.download(entityModel);
  }

  static Future<bool> hasModel(String entityModel) async {
    return await EntityModelManager.exist(entityModel);
  }

  static Future<bool> deleteModel(String entityModel) async {
    return await EntityModelManager.delete(entityModel);
  }
}
 */
