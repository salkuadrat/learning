import 'dart:async';

import 'package:learning_entity_extraction/learning_entity_extraction.dart'
    as LEE;
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_language/learning_language.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:learning_translate/learning_translate.dart';
import 'package:learning_smart_reply/learning_smart_reply.dart';

class ML {
  static Future<String> identifyLanguage(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    final result = await identifier.identify(text);
    identifier.dispose();
    return result;
  }

  static Future<List<IdentifiedLanguage>> identifyPossibleLanguages(String text,
      {double confidenceThreshold = 0.5}) async {
    LanguageIdentifier identifier =
        LanguageIdentifier(confidenceThreshold: confidenceThreshold);
    final result = await identifier.idenfityPossibleLanguages(text);
    identifier.dispose();
    return result;
  }

  static Future<String> translate(String text,
      {required String from, required String to}) async {
    Translator translator = Translator(from: from, to: to);
    String result = await translator.translate(text);
    translator.dispose();
    return result;
  }

  static Future<List> generateSmartReplies(List<Message> history) async {
    SmartReplyGenerator smartReply = SmartReplyGenerator();
    var result = await smartReply.generateReplies(history);
    smartReply.dispose();
    return result;
  }

  static Future<List> extractEntity(String text,
      {String entityModel = LEE.ENGLISH}) async {
    LEE.EntityExtractor extractor = LEE.EntityExtractor(model: entityModel);
    List result = await extractor.extract(text);
    extractor.dispose();
    return result;
  }

  static Future<RecognizedText?> textRecognition(InputImage image) async {
    TextRecognition textRecognition = TextRecognition();
    RecognizedText? result = await textRecognition.process(image);
    textRecognition.dispose();
    return result;
  }

  static Future<List<Face>> detectFaces(
    InputImage image, {
    FaceDetectorMode mode = FaceDetectorMode.fast,
    bool detectLandmark = false,
    bool detectContour = false,
    bool enableClassification = false,
    bool enableTracking = false,
    double minFaceSize = 0.15,
  }) async {
    FaceDetector detector = FaceDetector(
      mode: mode,
      detectLandmark: detectLandmark,
      detectContour: detectContour,
      enableClassification: enableClassification,
      enableTracking: enableTracking,
      minFaceSize: minFaceSize,
    );
    List<Face> result = await detector.detect(image);
    detector.dispose();
    return result;
  }
}
