import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'dart:async';

import 'package:learning_language/learning_language.dart';
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
        create: (_) => IdentifyLanguageState(),
        child: IdentifyLanguagePage(),
      ),
    );
  }
}

class IdentifyLanguagePage extends StatefulWidget {
  @override
  _IdentifyLanguagePageState createState() => _IdentifyLanguagePageState();
}

class _IdentifyLanguagePageState extends State<IdentifyLanguagePage> {
  TextEditingController _controller = TextEditingController();
  LanguageIdentifier _identifier = LanguageIdentifier();

  IdentifyLanguageState get state => Provider.of(context, listen: false);

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance?.addPostFrameCallback((_) => identify());
  }

  @override
  void dispose() {
    _controller.dispose();
    _identifier.dispose();
    super.dispose();
  }

  /* Future<void> identify() async {
    String text = 'Baby, you light up my world like nobody else';

    List<IdentifiedLanguage> possibleLanguages =
        await _identifier.idenfityPossibleLanguages(text);
    print('Possible Languages:');
    print(possibleLanguages);

    String language = await _identifier.identify(text);
    print('Language: $language');
  } */

  Future<void> _startIdentifying() async {
    state.startProcessing();

    String language = await _identifier.identify(_controller.text);
    state.data = language == 'und' ? 'Not Identified' : language.toUpperCase();
    state.stopProcessing();
  }

  Future<void> _startIdentifyingPossibleLanguages() async {
    state.startProcessing();

    List<IdentifiedLanguage> languages =
        await _identifier.idenfityPossibleLanguages(_controller.text);

    String result = '';
    for (IdentifiedLanguage l in languages) {
      result += '${l.language.toUpperCase()} (${l.confidence.toString()})\n';
    }

    state.data = result;
    state.stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Language Identification'),
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
              text: 'Identify Language',
              onPressed: _startIdentifying,
            ),
            SizedBox(height: 8),
            NormalBlueButton(
              text: 'Idenfity Possible Languages',
              onPressed: _startIdentifyingPossibleLanguages,
            ),
            SizedBox(height: 25),
            Consumer<IdentifyLanguageState>(
              builder: (_, state, __) => Center(
                child: Text(
                  state.isProcessing ? 'Identifying language...' : state.data,
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
    );
  }
}

class IdentifyLanguageState extends ChangeNotifier {
  String _data = '';
  bool _isProcessing = false;

  String get data => _data;
  bool get isProcessing => _isProcessing;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
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
