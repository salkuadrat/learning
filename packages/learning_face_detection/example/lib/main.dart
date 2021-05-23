import 'package:flutter/material.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FaceDetector _detector;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _detector.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _isProcessing = true;
    });
  }

  void _stop() {
    setState(() {
      _isProcessing = false;
    });
  }

  void init() {
    _detector = FaceDetector(
      performance: 'fast',
      landmark: 'all',
      classification: 'all',
      contour: 'all',
      enableTracking: true,
    );
  }

  Future<void> _detectFaces(InputImage image) async {
    print('Input image ${image.type}');

    if (!_isProcessing) {
      _start();

      List<Face> result = await _detector.detect(image);
      print(result);

      _stop();
    }
  }

  Widget get _overlay {
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
        mode: InputCameraMode.gallery,
        title: 'Face Detection',
        onImage: _detectFaces,
        overlay: _overlay,
      ),
    );
  }
}
