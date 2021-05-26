import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:learning_smart_reply/learning_smart_reply.dart';
import 'package:uuid/uuid.dart';

class LearningSmartReply extends StatefulWidget {
  @override
  _LearningSmartReplyState createState() => _LearningSmartReplyState();
}

class _LearningSmartReplyState extends State<LearningSmartReply> {
  SmartReplyGenerator _smartReply = SmartReplyGenerator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await testSmartReply();
    });
  }

  @override
  void dispose() {
    _smartReply.dispose();
    super.dispose();
  }

  Future<void> testSmartReply() async {
    print('testSmartReply...');

    Uuid uuid = Uuid();
    String userId = uuid.v4();
    int now = DateTime.now().millisecondsSinceEpoch;

    List<Message> history = [
      Message('Hi', user: userId, timestamp: now - (60 * 60 * 1000)),
      Message('How are you?', timestamp: now - (20 * 60 * 1000)),
      Message('I am fine. Thanks.',
          user: userId, timestamp: now - (10 * 60 * 1000)),
    ];

    _smartReply = SmartReplyGenerator();
    var result = await _smartReply.generateReplies(history);

    print('testSmartReply Result:');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Reply'),
      ),
      body: Container(),
    );
  }
}
