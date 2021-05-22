import 'package:flutter/services.dart';

import '../shared.dart';

class Translator {
  final String from;
  final String to;

  Translator(this.from, this.to);

  Future<String> translate(String text) async {
    try {
      return await channel.invokeMethod('nTranslateText', <String, dynamic>{
        'from': from,
        'to': to,
        'text': text,
      });
    } on PlatformException catch (e) {
      print(e.message);
      return text;
    }
  }

  Future dispose() async {
    await channel.invokeMethod('disposeTranslateText');
  }
}
