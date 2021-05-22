import 'package:flutter/material.dart';
import 'package:learning_smart_reply/learning_smart_reply.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    await _smartReply.setHistory(history);
    var result = await _smartReply.generateReplies();
    print('testSmartReply Result:');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Smart Reply'),
        ),
        body: Container(),
      ),
    );
  }
}
