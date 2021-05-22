import 'package:flutter/services.dart';

class TranslationModelManager {
  static final MethodChannel _channel =
      MethodChannel('LearningTranslationModelManager');

  static Future<List> list() async {
    try {
      List result = await _channel.invokeMethod('list');
      return result;
    } on PlatformException catch (e) {
      print(e.message);
      return <String>[];
    }
  }

  static Future<bool> download(String translationModel) async {
    try {
      return await _channel.invokeMethod(
          'download', <String, dynamic>{'model': translationModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> check(String translationModel) async {
    try {
      return await _channel
          .invokeMethod('check', <String, dynamic>{'model': translationModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> delete(String translationModel) async {
    try {
      return await _channel
          .invokeMethod('delete', <String, dynamic>{'model': translationModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }
}
