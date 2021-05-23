import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextRecognition? _textRecognition;
  InputImage? _image;

  bool _isProcessing = false;

  @override
  void initState() {
    _textRecognition = TextRecognition();
    super.initState();
  }

  @override
  void dispose() {
    _textRecognition?.dispose();
    super.dispose();
  }

  void _startProcessing() {
    setState(() {
      _isProcessing = true;
    });
  }

  void _stopProcessing() {
    setState(() {
      _isProcessing = false;
    });
  }

  Future<void> _startRecognition() async {
    print('_startRecognition');

    if (_image != null) {
      _startProcessing();
      RecognizedText? result = await _textRecognition?.process(_image!);

      if (result != null) {
        print(result);
      }

      _stopProcessing();
    }
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
      home: InputCameraView(
        canSwitchMode: false,
        mode: InputCameraMode.gallery,
        title: 'Text Recognition',
        onImage: (image) {
          _image = image;
        },
        action: 'Start Recognition',
        onTapAction: _startRecognition,
      ),
    );
  }
}
