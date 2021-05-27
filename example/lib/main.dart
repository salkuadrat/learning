import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nlp/entity_extraction.dart';
import 'nlp/language.dart';
import 'nlp/translate.dart';
import 'vision/barcode_scanning.dart';
import 'vision/digital_ink_recognition.dart';
import 'vision/face_detection.dart';
import 'vision/image_labeling.dart';
import 'vision/oject_detection.dart';
import 'vision/pose_detection.dart';
import 'vision/selfie_segmentation.dart';
import 'vision/text_recognition.dart';

void main() {
  runApp(LearningApp());
}

class LearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: LearningHome(),
    );
  }
}

class LearningHome extends StatefulWidget {
  @override
  _LearningHomeState createState() => _LearningHomeState();
}

class _LearningHomeState extends State<LearningHome> {
  Widget _menuItem(String text, Widget page) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        title: Text(text),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Machine Learning Kit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _menuItem(
              'Text Recognition',
              ChangeNotifierProvider(
                create: (_) => LearningTextRecognitionState(),
                child: LearningTextRecognition(),
              ),
            ),
            _menuItem(
              'Face Detection',
              ChangeNotifierProvider(
                create: (_) => LearningFaceDetectionState(),
                child: LearningFaceDetection(),
              ),
            ),
            _menuItem(
              'Pose Detection',
              ChangeNotifierProvider(
                create: (_) => LearningPoseDetectionState(),
                child: LearningPoseDetection(),
              ),
            ),
            _menuItem(
              'Selfie Segmentation',
              ChangeNotifierProvider(
                create: (_) => LearningSelfieSegmentationState(),
                child: LearningSelfieSegmentation(),
              ),
            ),
            _menuItem(
              'Barcode Scanning',
              ChangeNotifierProvider(
                create: (_) => LearningBarcodeScanningState(),
                child: LearningBarcodeScanning(),
              ),
            ),
            _menuItem(
              'Image Labeling',
              ChangeNotifierProvider(
                create: (_) => LearningImageLabelingState(),
                child: LearningImageLabeling(),
              ),
            ),
            _menuItem(
              'Object Detection & Tracking',
              ChangeNotifierProvider(
                create: (_) => LearningObjectDetectionState(),
                child: LearningObjectDetection(),
              ),
            ),
            _menuItem(
              'Digital Ink Recognition',
              ChangeNotifierProvider(
                create: (_) => LearningDigitalInkRecognitionState(),
                child: LearningDigitalInkRecognition(),
              ),
            ),
            _menuItem(
              'Language Detection',
              ChangeNotifierProvider(
                create: (_) => LearningLanguageState(),
                child: LearningLanguage(),
              ),
            ),
            _menuItem(
              'On-device Translation',
              ChangeNotifierProvider(
                create: (_) => LearningTranslateState(),
                child: LearningTranslate(),
              ),
            ),
            _menuItem(
              'Entity Extraction',
              ChangeNotifierProvider(
                create: (_) => LearningEntityExtractionState(),
                child: LearningEntityExtraction(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
