import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_image_labeling/learning_image_labeling.dart';
import 'package:provider/provider.dart';

class LearningImageLabeling extends StatefulWidget {
  @override
  _LearningImageLabelingState createState() => _LearningImageLabelingState();
}

class _LearningImageLabelingState extends State<LearningImageLabeling> {
  LearningImageLabelingState get state => Provider.of(context, listen: false);
  ImageLabeling _imageLabeling = ImageLabeling();

  @override
  void dispose() {
    _imageLabeling.dispose();
    super.dispose();
  }

  Future<void> _processLabeling(InputImage image) async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.labels = await _imageLabeling.process(image);
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      cameraDefault: InputCameraType.rear,
      title: 'Image Labeling',
      onImage: _processLabeling,
      overlay: Consumer<LearningImageLabelingState>(
        builder: (_, state, __) {
          if (state.isEmpty) {
            return Container();
          }

          if (state.isProcessing && state.notFromLive) {
            return Center(
              child: Container(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }

          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(state.toString(),
                  style: TextStyle(fontWeight: FontWeight.w500)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LearningImageLabelingState extends ChangeNotifier {
  InputImage? _image;
  List<Label> _labels = [];
  bool _isProcessing = false;

  InputImage? get image => _image;
  List<Label> get labels => _labels;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isProcessing => _isProcessing;
  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => _labels.isEmpty;
  bool get notFromLive => type != 'bytes';

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set isProcessing(bool isProcessing) {
    _isProcessing = isProcessing;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set labels(List<Label> labels) {
    _labels = labels;
    notifyListeners();
  }

  @override
  String toString() {
    List<String> result = labels.map((label) => label.label).toList();
    return result.join(', ');
  }
}
