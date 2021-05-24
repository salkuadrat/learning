import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_object_detection/learning_object_detection.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class ObjectDetectionData extends ChangeNotifier {
  InputImage? _image;
  List<DetectedObject> _objects = [];

  InputImage? get image => _image;
  List<DetectedObject> get objects => _objects;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isEmpty => _objects.isEmpty;
  bool get isFromLive => type == 'bytes';
  bool get notFromLive => !isFromLive;

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set objects(List<DetectedObject> objects) {
    _objects = objects;
    notifyListeners();
  }

  void clear() {
    _objects.clear();
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
        create: (_) => ObjectDetectionData(),
        child: ObjectDetectionPage(),
      ),
    );
  }
}

class ObjectDetectionPage extends StatefulWidget {
  @override
  _ObjectDetectionPageState createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {
  ObjectDetectionData get data =>
      Provider.of<ObjectDetectionData>(context, listen: false);
  bool _isProcessing = false;

  ObjectDetector _detector = ObjectDetector(
    isStream: true,
    enableClassification: true,
    enableTracking: true,
  );

  @override
  void dispose() {
    _detector.dispose();
    super.dispose();
  }

  Future<void> _detectObjects(InputImage image) async {
    if (!_isProcessing) {
      _isProcessing = true;

      if (image.type != 'bytes') {
        data.objects = [];
      }

      List<DetectedObject> result = await _detector.detect(image);

      _isProcessing = false;
      data.image = image;
      data.objects = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: 'Face Detection',
      onImage: _detectObjects,
      cameraDefault: InputCameraType.rear,
      overlay: Consumer<ObjectDetectionData>(
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

          return Container();
        },
      ),
    );
  }
}
