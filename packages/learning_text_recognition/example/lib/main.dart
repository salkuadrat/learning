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
  RecognizedText? _result;

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

  void _onImageChanged(InputImage image) {
    setState(() {
      _image = image;
      _result = null;
    });
  }

  Future<void> _startRecognition() async {
    print('_startRecognition');

    if (_image != null) {
      setState(() {
        _isProcessing = true;
      });

      final result = await _textRecognition?.process(_image!);
      print(result);

      setState(() {
        _result = result;
        _isProcessing = false;
      });
    }
  }

  Widget get _overlay {
    if (_isProcessing) {
      return Center(
        child: Container(
          width: 32, height: 32,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_result != null) {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
          child: Text(_result!.text, style: TextStyle(fontWeight: FontWeight.w500)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
    }

    return Container();
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
        onImage: _onImageChanged,
        action: 'Start Recognition',
        onTapAction: _startRecognition,
        overlay: _overlay,
      ),
    );
  }
}
