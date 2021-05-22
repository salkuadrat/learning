import 'package:flutter/services.dart';

class EntityModelManager {
  static final MethodChannel channel =
      MethodChannel('LearningEntityModelManager');

  static Future<List> list() async {
    try {
      List result = await channel.invokeMethod('list');
      return result;
    } on PlatformException catch (e) {
      print(e.message);
      return <String>[];
    }
  }

  static Future<bool> download(String entityModel) async {
    try {
      return await channel
          .invokeMethod('download', <String, dynamic>{'model': entityModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> exist(String entityModel) async {
    try {
      return await channel
          .invokeMethod('check', <String, dynamic>{'model': entityModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> delete(String entityModel) async {
    try {
      return await channel
          .invokeMethod('delete', <String, dynamic>{'model': entityModel});
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }
}
