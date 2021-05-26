import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:provider/provider.dart';

class LearningFaceDetection extends StatefulWidget {
  @override
  _LearningFaceDetectionState createState() => _LearningFaceDetectionState();
}

class _LearningFaceDetectionState extends State<LearningFaceDetection> {
  LearningFaceDetectionState get state => Provider.of(context, listen: false);

  FaceDetector _detector = FaceDetector(
    mode: FaceDetectorMode.accurate,
    detectLandmark: true,
    detectContour: true,
    enableClassification: true,
    enableTracking: true,
  );

  @override
  void dispose() {
    _detector.dispose();
    super.dispose();
  }

  Future<void> _detectFaces(InputImage image) async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _detector.detect(image);
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: 'Face Detection',
      onImage: _detectFaces,
      overlay: Consumer<LearningFaceDetectionState>(
        builder: (_, state, __) {
          if (state.isEmpty) {
            return Container();
          }

          Size originalSize = state.size!;
          Size size = MediaQuery.of(context).size;

          // if image source from gallery
          // image display size is scaled to 360x360 with retaining aspect ratio
          if (state.notFromLive) {
            if (originalSize.aspectRatio > 1) {
              size = Size(360.0, 360.0 / originalSize.aspectRatio);
            } else {
              size = Size(360.0 * originalSize.aspectRatio, 360.0);
            }
          }

          return FaceOverlay(
            size: size,
            originalSize: originalSize,
            rotation: state.rotation,
            faces: state.data,
            contourColor: Colors.white.withOpacity(0.8),
            landmarkColor: Colors.lightBlue.withOpacity(0.8),
          );
        },
      ),
    );
  }
}

class LearningFaceDetectionState extends ChangeNotifier {
  InputImage? _image;
  List<Face> _data = [];
  bool _isProcessing = false;

  InputImage? get image => _image;
  List<Face> get data => _data;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => data.isEmpty;
  bool get isFromLive => type == 'bytes';
  bool get notFromLive => !isFromLive;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;

    if (notFromLive) {
      _data = [];
    }
    notifyListeners();
  }

  set data(List<Face> data) {
    _data = data;
    notifyListeners();
  }
}
