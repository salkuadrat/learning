import 'package:flutter/services.dart';

class SmartReplyGenerator {
  final MethodChannel channel = MethodChannel('LearningSmartReply');

  SmartReplyGenerator();

  Future<void> refresh() async {
    try {
      await channel.invokeMethod('refresh');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> add(Message message) async {
    try {
      await channel.invokeMethod('push', <String, dynamic>{
        'user': message.user,
        'text': message.text,
        'timestamp': message.timestamp,
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<List> generateReplies(List<Message> history) async {
    List result = [];

    for (Message message in history) {
      await add(message);
    }

    try {
      result = await channel.invokeMethod('generateReplies');
    } on PlatformException catch (e) {
      print(e.message);
    }

    return result;
  }

  Future<void> dispose() async {
    await channel.invokeMethod('dispose');
  }
}

class Message {
  final String user;
  final String text;
  final int timestamp;

  Message(this.text, {this.user = '', required this.timestamp});
}
