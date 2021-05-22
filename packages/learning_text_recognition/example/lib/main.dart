import 'package:flutter/material.dart';
import 'package:learning_input_image/input_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InputImage? _image;

  void _processImage(InputImage image) {
    _image = image;
  }

  void _startRecognition() {
    if (_image != null) {}
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
        onImage: _processImage,
        action: 'Start Recognition',
        onTapAction: _startRecognition,
      ),
    );
  }
}
