import 'package:flutter/material.dart';
import 'package:learning_entity_extraction/learning_entity_extraction.dart';
import 'package:learning_input_image/input_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  EntityExtractor _extractor = EntityExtractor();

  String _result = '';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      //await testModelManager();
      //await testExtraction();
    });
  }

  @override
  void dispose() {
    _extractor.dispose();
    super.dispose();
  }

  /* Future<void> testExtraction() async {
    String text =
        'Meet me at 1600 Amphitheatre Parkway, Mountain View, CA, 94043 Let’s organize a meeting to discuss.';
    List result = await _extractor.extract(text);
    print(result);
  } */

  Future<void> testModelManager() async {
    var models = await EntityModelManager.list();
    print(models);
    var downloaded = await EntityModelManager.download(ENGLISH);
    print('Donwloaded: $downloaded');
    var exist = await EntityModelManager.exist(ENGLISH);
    print('HasModel: $exist');
    models = await EntityModelManager.list();
    print(models);
    var deleted = await EntityModelManager.delete(ENGLISH);
    print('Deleted: $deleted');
    models = await EntityModelManager.list();
    print(models);
  }

  Future<void> _extract() async {
    String text = _controller.text;

    setState(() {
      _isProcessing = true;
    });

    List result = await _extractor.extract(text);

    _result = '';
    for (var item in result) {
      _result += '${item.toString()}\n\n';
    }

    setState(() {
      _isProcessing = false;
    });
  }

  void _clearResult() {
    setState(() {
      _result = '';
    });
  }

  String get _displayText {
    if (_isProcessing) {
      return 'Processing...';
    }

    return _result;
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
          title: Text('Entity Extraction'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextField(
                autofocus: true,
                controller: _controller,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                ),
                minLines: 5,
                maxLines: 10,
                style: TextStyle(fontSize: 18, color: Colors.blueGrey[700]),
                onChanged: (_) => _clearResult(),
              ),
              SizedBox(height: 15),
              NormalBlueButton(
                text: 'Extract Entity',
                onPressed: _extract,
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  _displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
