import 'dart:async';

import 'package:learning_barcode_scanning/learning_barcode_scanning.dart';
import 'package:learning_entity_extraction/learning_entity_extraction.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_image_labeling/learning_image_labeling.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_language/learning_language.dart';
import 'package:learning_object_detection/learning_object_detection.dart';
import 'package:learning_pose_detection/learning_pose_detection.dart';
import 'package:learning_selfie_segmentation/learning_selfie_segmentation.dart';
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
      {String entityModel = 'english'}) async {
    EntityExtractor extractor = EntityExtractor(model: entityModel);
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

  static Future<Pose?> detectPose(InputImage image, {isStream: false}) async {
    PoseDetector detector = PoseDetector(isStream: isStream);
    Pose? result = await detector.detect(image);
    detector.dispose();
    return result;
  }

  static Future<List<DetectedObject>> detectObjects(
    InputImage image, {
    isStream: false,
    enableClassification: true,
    enableMultipleObjects: true,
  }) async {
    ObjectDetector detector = ObjectDetector(
      isStream: isStream,
      enableClassification: enableClassification,
      enableMultipleObjects: enableMultipleObjects,
    );

    List<DetectedObject> result = await detector.detect(image);
    detector.dispose();
    return result;
  }

  static Future<List> scanBarcode(InputImage image,
      {List<BarcodeFormat> formats = const []}) async {
    BarcodeScanner scanner = BarcodeScanner(formats: formats);
    List result = await scanner.scan(image);
    scanner.dispose();
    return result;
  }

  static Future<List<Label>> imageLabeling(InputImage image,
      {double confidenceThreshold = 0.8}) async {
    ImageLabeling imageLabeling = ImageLabeling();
    List<Label> labels = await imageLabeling.process(image);
    imageLabeling.dispose();
    return labels;
  }

  static Future<SegmentationMask?> selfieSegmentation(
    InputImage image, {
    bool isStream = true,
    bool enableRawSizeMask = false,
  }) async {
    SelfieSegmenter segmenter = SelfieSegmenter(
        isStream: isStream, enableRawSizeMask: enableRawSizeMask);
    SegmentationMask? mask = await segmenter.process(image);
    segmenter.dispose();
    return mask;
  }
}
