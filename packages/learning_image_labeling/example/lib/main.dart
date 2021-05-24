import 'package:flutter/material.dart';
import 'package:learning_image_labeling/learning_image_labeling.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class ImageLabelingData extends ChangeNotifier {
  InputImage? _image;
  List _labels = [];

  InputImage? get image => _image;
  List get labels => _labels;
  String get label => _labels.isNotEmpty ? _labels.first['label'] : '';

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isEmpty => _labels.isEmpty;
  bool get isFromLive => type == 'bytes';
  bool get notFromLive => !isFromLive;

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set labels(List labels) {
    _labels = labels;
    notifyListeners();
  }

  void clear() {
    _labels.clear();
    _image = null;
    notifyListeners();
  }

  @override
  String toString() {
    List<String> result = [];
    for (Map label in labels) {
      result.add(label['label']);
    }
    return result.join(', ');
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
        create: (_) => ImageLabelingData(),
        child: ImageLabelingPage(),
      ),
    );
  }
}

class ImageLabelingPage extends StatefulWidget {
  @override
  _ImageLabelingPageState createState() => _ImageLabelingPageState();
}

class _ImageLabelingPageState extends State<ImageLabelingPage> {
  ImageLabelingData get data =>
      Provider.of<ImageLabelingData>(context, listen: false);
  bool _isProcessing = false;

  ImageLabeling _imageLabeling = ImageLabeling();

  @override
  void dispose() {
    _imageLabeling.dispose();
    super.dispose();
  }

  Future<void> _processLabeling(InputImage image) async {
    if (!_isProcessing) {
      _isProcessing = true;

      if (image.type != 'bytes') {
        data.labels = [];
      }

      List result = await _imageLabeling.process(image);

      _isProcessing = false;
      data.image = image;
      data.labels = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      title: 'Image Labeling',
      onImage: _processLabeling,
      overlay: Consumer<ImageLabelingData>(
        builder: (_, data, __) {
          if (data.isEmpty) {
            return Container();
          }

          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: Colors.white.withOpacity(0.9),
              child: Text(data.toString()),
            ),
          );
        },
      ),
    );
  }
}
