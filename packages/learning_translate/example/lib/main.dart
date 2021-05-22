import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'dart:async';

import 'package:learning_translate/learning_translate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  Translator _translator = Translator(from: FRENCH, to: ENGLISH);
  //LanguageIdentifier _identifier = LanguageIdentifier();

  String _result = '';
  bool _isProcessing = false;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      //await testModelManager();
      //await testTranslate();

      // Predownload translation model for FRENCH
      await TranslationModelManager.download(FRENCH);
    });
  }

  @override
  void dispose() {
    //_identifier.dispose();
    _translator.dispose();
    super.dispose();
  }

  Future<void> testModelManager() async {
    var models = await TranslationModelManager.list();
    print(models);
    var downloaded = await TranslationModelManager.download(KOREAN);
    print('Donwloaded: $downloaded');
    var exist = await TranslationModelManager.check(KOREAN);
    print('Check model: $exist');
    models = await TranslationModelManager.list();
    print(models);
    var deleted = await TranslationModelManager.delete(KOREAN);
    print('Deleted: $deleted');
    models = await TranslationModelManager.list();
    print(models);
  }

  /* Future<void> testTranslate() async {
    print('translate...');
    String text = 'Baby, you light up my world like nobody else';
    Translator translator = Translator(from: ENGLISH, to: INDONESIAN);
    String result = await translator.translate(text);
    print('Original: $text');
    print('Translation: $result');
    translator.dispose();
  } */

  Future<void> _startTranslating() async {
    String text = _controller.text;

    setState(() {
      _isProcessing = true;
    });

    //String language = await _identifier.identify(text);
    bool exist = await TranslationModelManager.check(FRENCH);

    if (!exist) {
      setState(() {
        _isDownloading = true;
      });

      await TranslationModelManager.download(FRENCH);

      setState(() {
        _isDownloading = false;
      });
    }

    String result = await _translator.translate(text);

    setState(() {
      _result = result;
      _isProcessing = false;
    });
  }

  void _clearResult() {
    setState(() {
      _result = '';
    });
  }

  String get _displayText {
    if (_isDownloading) {
      return 'Downloading model...';
    }

    if (_isProcessing) {
      return 'Translating...';
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
          title: Text('On-Device Translation'),
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
                text: 'Translate from FR to EN',
                onPressed: _startTranslating,
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  _displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
