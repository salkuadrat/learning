import 'package:flutter/material.dart';
import 'package:learning_input_image/input_image.dart';
import 'dart:async';

import 'package:learning_language/learning_language.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  LanguageIdentifier _identifier = LanguageIdentifier();

  String _result = '';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance?.addPostFrameCallback((_) => identify());
  }

  @override
  void dispose() {
    _identifier.dispose();
    super.dispose();
  }

  Future<void> identify() async {
    String text = 'Baby, you light up my world like nobody else';
    
    List<IdentifiedLanguage> possibleLanguages =
        await _identifier.idenfityPossibleLanguages(text);
    print('Possible Languages:');
    print(possibleLanguages);

    String language = await _identifier.identify(text);
    print('Language: $language');
  }

  Future<void> _startIdentifying() async {
    setState(() {
      _isProcessing = true;
    });

    String text = _controller.text;
    String language = await _identifier.identify(text);
    
    setState(() {
      _result = language.toUpperCase();
      _isProcessing = false;
    });
  }

  Future<void> _startIdentifyingPossibleLanguages() async {
    setState(() {
      _isProcessing = true;
    });

    String text = _controller.text;
    List<IdentifiedLanguage> langs =
        await _identifier.idenfityPossibleLanguages(text);
    
    String result = '';
    for (IdentifiedLanguage lang in langs) {
      result +=
          '${lang.language.toUpperCase()} (${lang.confidence.toString()})\n';
    }

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
                onChanged: (_) => _clearResult(),
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
              Center(
                child: Text(
                  _isProcessing ? 'Processing identification...' : _result,
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
