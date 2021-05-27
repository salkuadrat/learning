import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'dart:async';

import 'package:learning_translate/learning_translate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: ChangeNotifierProvider(
        create: (_) => TranslateTextState(),
        child: TranslateTextPage(),
      ),
    );
  }
}

class TranslateTextPage extends StatefulWidget {
  @override
  _TranslateTextPageState createState() => _TranslateTextPageState();
}

class _TranslateTextPageState extends State<TranslateTextPage> {
  TextEditingController _controller = TextEditingController();
  Translator _translator = Translator(from: FRENCH, to: ENGLISH);
  //LanguageIdentifier _identifier = LanguageIdentifier();

  TranslateTextState get state => Provider.of(context, listen: false);

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
    _controller.dispose();
    _translator.dispose();
    super.dispose();
  }

  /* Future<void> testModelManager() async {
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
  } */

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
    bool exist = await TranslationModelManager.check(FRENCH);

    if (!exist) {
      state.startDownloading();
      await TranslationModelManager.download(FRENCH);
      state.stopDownloading();
    }

    state.startProcessing();
    state.data = await _translator.translate(_controller.text);
    state.stopProcessing();
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
                onChanged: (_) => state.clear(),
              ),
              SizedBox(height: 15),
              NormalBlueButton(
                text: 'Translate from FR to EN',
                onPressed: _startTranslating,
              ),
              SizedBox(height: 25),
              Consumer<TranslateTextState>(
                builder: (_, state, __) => Center(
                  child: Text(
                    state.data,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TranslateTextState extends ChangeNotifier {
  String _data = '';
  bool _isProcessing = false;
  bool _isDownloading = false;

  String get data => _data;
  bool get isProcessing => _isProcessing;
  bool get isDownloading => _isDownloading;

  void startProcessing() {
    _data = 'Translating...';
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  void startDownloading() {
    _data = 'Downloading translation model...';
    _isDownloading = true;
    notifyListeners();
  }

  void stopDownloading() {
    _isDownloading = false;
    notifyListeners();
  }

  set data(String data) {
    _data = data;
    notifyListeners();
  }

  void clear() {
    _data = '';
    notifyListeners();
  }
}
