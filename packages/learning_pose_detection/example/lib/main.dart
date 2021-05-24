import 'package:flutter/material.dart';
import 'package:learning_pose_detection/learning_pose_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class PoseDetectionData extends ChangeNotifier {
  InputImage? _image;
  Pose? _pose;

  InputImage? get image => _image;
  Pose? get pose => _pose;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isEmpty => _pose == null;
  bool get isFromLive => type == 'bytes';
  bool get notFromLive => !isFromLive;

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set pose(Pose? pose) {
    _pose = pose;
    notifyListeners();
  }

  void clear() {
    _pose = null;
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
        create: (_) => PoseDetectionData(),
        child: PoseDetectionPage(),
      ),
    );
  }
}

class PoseDetectionPage extends StatefulWidget {
  @override
  _PoseDetectionPageState createState() => _PoseDetectionPageState();
}

class _PoseDetectionPageState extends State<PoseDetectionPage> {
  PoseDetectionData get data =>
      Provider.of<PoseDetectionData>(context, listen: false);
  bool _isProcessing = false;

  PoseDetector _detector = PoseDetector(isStream: false);

  @override
  void dispose() {
    _detector.dispose();
    super.dispose();
  }

  Future<void> _detectPose(InputImage image) async {
    if (!_isProcessing) {
      _isProcessing = true;

      if (image.type != 'bytes') {
        data.pose = null;
      }

      Pose? pose = await _detector.detect(image);

      _isProcessing = false;
      data.image = image;
      data.pose = pose;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      mode: InputCameraMode.gallery,
      title: 'Pose Detection',
      onImage: _detectPose,
      overlay: Consumer<PoseDetectionData>(
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

          return PoseOverlay(
            size: size,
            originalSize: originalSize,
            rotation: data.rotation!,
            pose: data.pose!,
          );
        },
      ),
    );
  }
}
