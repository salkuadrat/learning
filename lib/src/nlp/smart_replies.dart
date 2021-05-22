import 'package:flutter/services.dart';

import '../shared.dart';

class SmartReplies {
  SmartReplies();

  Future addConversation(Conversation conversation) async {
    await channel.invokeMethod('nPushSmartReplies', <String, dynamic>{
      'user': conversation.user,
      'text': conversation.text,
      'timestamp': conversation.timestamp,
    });
  }

  Future<List<String>> getReplies() async {
    List<String> result = [];

    try {
      result = await channel.invokeMethod('nSmartReplies');
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future dispose() async {
    await channel.invokeMethod('disposeSmartReplies');
  }
}

class Conversation {
  final String user;
  final String text;
  final int timestamp;

  Conversation(this.text, {this.user = '', required this.timestamp});
}
