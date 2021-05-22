import 'package:flutter/services.dart';

class Translator {
  final MethodChannel channel = MethodChannel('LearningTranslate');
  final String from;
  final String to;
  final bool isDownloadRequireWifi;

  Translator({
    required this.from,
    required this.to,
    this.isDownloadRequireWifi = false,
  });

  Future<String> translate(String text) async {
    try {
      return await channel.invokeMethod('translate', <String, dynamic>{
        'from': from,
        'to': to,
        'text': text,
        'isDownloadRequireWifi': isDownloadRequireWifi,
      });
    } on PlatformException catch (e) {
      print(e.message);
      return text;
    }
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}
