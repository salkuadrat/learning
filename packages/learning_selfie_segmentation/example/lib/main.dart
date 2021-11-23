import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_selfie_segmentation/learning_selfie_segmentation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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
        create: (_) => SelfieSegmentationState(),
        child: SelfieSegmentationPage(),
      ),
    );
  }
}

class SelfieSegmentationPage extends StatefulWidget {
  @override
  _SelfieSegmentationPageState createState() => _SelfieSegmentationPageState();
}

class _SelfieSegmentationPageState extends State<SelfieSegmentationPage> {
  SelfieSegmentationState get state => Provider.of(context, listen: false);

  SelfieSegmenter _segmenter = SelfieSegmenter(
    isStream: true,
    enableRawSizeMask: false,
  );

  @override
  void dispose() {
    _segmenter.dispose();
    super.dispose();
  }

  Future<void> _process(InputImage image) async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.isFromLive = image.type == 'bytes';

      if (state.notFromLive) {
        ImageProperties properties =
            await FlutterNativeImage.getImageProperties(image.path!);

        double aspectRatio = properties.width! / properties.height!;
        int targetWidth = aspectRatio > 1.0 ? 360 : (360 * aspectRatio).round();
        int targetHeight =
            aspectRatio > 1.0 ? (360 / aspectRatio).round() : 360;

        File scaledImage = await FlutterNativeImage.compressImage(
          image.path!,
          quality: 90,
          targetWidth: aspectRatio > 1.0 ? 360 : (360 * aspectRatio).round(),
          targetHeight: aspectRatio > 1.0 ? (360 / aspectRatio).round() : 360,
        );

        image = InputImage.fromFile(
          scaledImage,
          metadata: InputImageData(
            size: Size(targetWidth.toDouble(), targetHeight.toDouble()),
            rotation: image.metadata?.rotation ?? InputImageRotation.ROTATION_0,
          ),
        );
      }

      state.image = image;
      SegmentationMask? mask = await _segmenter.process(image);
      state.data = mask;
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      mode: InputCameraMode.gallery,
      cameraDefault: InputCameraType.rear,
      // resolutionPreset: ResolutionPreset.high,
      title: 'Selfie Segmentation',
      onImage: _process,
      overlay: Consumer<SelfieSegmentationState>(
        builder: (_, state, __) {
          if (state.isEmpty) {
            return Container();
          }

          Size originalSize = state.size!;
          Size size =
              state.isFromLive ? MediaQuery.of(context).size : originalSize;

          return SegmentationOverlay(
            size: size,
            originalSize: originalSize,
            rotation: state.rotation,
            mask: state.data!,
          );
        },
      ),
    );
  }
}

class SelfieSegmentationState extends ChangeNotifier {
  InputImage? _image;
  SegmentationMask? _data;
  bool _isProcessing = false;
  bool _isFromLive = false;

  InputImage? get image => _image;
  SegmentationMask? get data => _data;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => _data == null;
  bool get isFromLive => _isFromLive;
  bool get notFromLive => !isFromLive;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set isFromLive(bool isFromLive) {
    _isFromLive = isFromLive;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;

    if (notFromLive) {
      _data = null;
    }
    notifyListeners();
  }

  set data(SegmentationMask? data) {
    _data = data;
    notifyListeners();
  }
}
