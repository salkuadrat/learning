import 'package:flutter/services.dart';

class DigitalInkModelManager {
  static MethodChannel channel =
      MethodChannel('LearningDigitalInkModelManager');

  static Future<bool> isDownloaded(String model) async {
    try {
      return await channel
          .invokeMethod('check', <String, dynamic>{'model': model});
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> download(String model) async {
    try {
      return await channel
          .invokeMethod('download', <String, dynamic>{'model': model});
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> delete(String model) async {
    try {
      return await channel
          .invokeMethod('delete', <String, dynamic>{'model': model});
    } catch (e) {
      print(e);
      return false;
    }
  }
}
