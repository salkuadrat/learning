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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LearningLanguageState()),
          ChangeNotifierProvider(create: (_) => LearningTranslateState()),
          ChangeNotifierProvider(
              create: (_) => LearningEntityExtractionState()),
          ChangeNotifierProvider(create: (_) => LearningTextRecognitionState()),
          ChangeNotifierProvider(create: (_) => LearningFaceDetectionState()),
          ChangeNotifierProvider(create: (_) => LearningPoseDetectionState()),
          ChangeNotifierProvider(create: (_) => LearningImageLabelingState()),
          ChangeNotifierProvider(create: (_) => LearningBarcodeScanningState()),
          ChangeNotifierProvider(create: (_) => LearningObjectDetectionState()),
          ChangeNotifierProvider(
              create: (_) => LearningSelfieSegmentationState()),
          ChangeNotifierProvider(
              create: (_) => LearningDigitalInkRecognitionState()),
        ],
        child: LearningHome(),
      ),
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
            _menuItem('Text Recognition', LearningTextRecognition()),
            _menuItem('Face Detection', LearningFaceDetection()),
            _menuItem('Pose Detection', LearningPoseDetection()),
            _menuItem('Selfie Segmentation', LearningSelfieSegmentation()),
            _menuItem('Barcode Scanning', LearningBarcodeScanning()),
            _menuItem('Image Labeling', LearningImageLabeling()),
            _menuItem('Object Detection & Tracking', LearningObjectDetection()),
            //_menuItem('Digital Ink Recognition', LearningDigitalInkRecognition()),
            _menuItem('Language Detection', LearningLanguage()),
            _menuItem('On-device Translation', LearningTranslate()),
            //_menuItem('Smart Reply', LearningSmartReply()),
            _menuItem('Entity Extraction', LearningEntityExtraction()),
          ],
        ),
      ),
    );
  }
}
