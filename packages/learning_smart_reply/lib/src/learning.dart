/* import 'generator.dart';

class MLSmartReply {
  static Future<List> generate(List<Message> history) async {
    SmartReplyGenerator smartReply = SmartReplyGenerator();
    
    await smartReply.refresh();
    for (Message message in history) {
      await smartReply.add(message);
    }

    List result = await smartReply.generateReplies();
    await smartReply.dispose();
    return result;
  }
}
 */
