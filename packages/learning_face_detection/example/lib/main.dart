import 'package:flutter/material.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class FaceDetectionData extends ChangeNotifier {
  InputImage? _image;
  List<Face> _faces = [];

  InputImage? get image => _image;
  List<Face> get faces => _faces;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isEmpty => _image == null || _faces.isEmpty;
  bool get isFromLive => type == 'bytes';
  bool get notFromLive => !isFromLive;

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set faces(List<Face> faces) {
    _faces = faces;
    notifyListeners();
  }

  void clear() {
    _faces.clear();
    _image = null;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: ChangeNotifierProvider(
        create: (_) => FaceDetectionData(),
        child: FaceDetectionPage(),
      ),
    );
  }
}

class FaceDetectionPage extends StatefulWidget {
  @override
  _FaceDetectionPageState createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  FaceDetectionData get data =>
      Provider.of<FaceDetectionData>(context, listen: false);
  bool _isProcessing = false;

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
    if (!_isProcessing) {
      _isProcessing = true;

      if (image.type != 'bytes') {
        data.faces = [];
      }

      List<Face> result = await _detector.detect(image);

      _isProcessing = false;
      data.image = image;
      data.faces = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: 'Face Detection',
      onImage: _detectFaces,
      overlay: Consumer<FaceDetectionData>(
        builder: (_, data, __) {
          if (data.isEmpty) {
            return Container();
          }

          Size originalSize = data.size!;
          Size size = MediaQuery.of(context).size;

          // if image source from gallery
          // image display size is scaled to 360x360 with retaining aspect ratio
          if (data.notFromLive) {
            if (originalSize.aspectRatio > 1) {
              size = Size(360.0, 360.0 / originalSize.aspectRatio);
            } else {
              size = Size(360.0 * originalSize.aspectRatio, 360.0);
            }
          }

          return FaceOverlay(
            size: size,
            originalSize: originalSize,
            rotation: data.rotation!,
            faces: data.faces,
            contourColor: Colors.white.withOpacity(0.8),
            landmarkColor: Colors.lightBlue.withOpacity(0.8),
          );
        },
      ),
    );
  }
}
