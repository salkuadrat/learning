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
        child: LearningHomePage(),
      ),
    );
  }
}

class LearningHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
