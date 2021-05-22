import 'package:flutter/services.dart';

import '../shared.dart';

class EntityExtractor {

  final String model;

  EntityExtractor(this.model);

  Future<List> extract(String text) async {
    var result = [];

    try {
      result = await channel.invokeMethod('nEntityExtractor', 
        <String, dynamic>{ 'text': text });
    } on PlatformException catch(e) {
      print(e.message);
    }

    return result;
  }

  Future dispose() async {
    await channel.invokeMethod('disposeEntityExtractor');
  }
}