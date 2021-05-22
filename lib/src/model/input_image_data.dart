import 'package:flutter/rendering.dart';

import '../shared.dart';

///Image metadata used when creating image from bytes.
class InputImageData {
  ///Size of image
  final Size size;

  ///Image rotation
  final InputImageRotation imageRotation;

  ///Input image format
  final InputImageFormat inputImageFormat;

  InputImageData(
      {required this.size,
      required this.imageRotation,
      this.inputImageFormat = InputImageFormat.NV21});

  ///Function to get the metadata of image processing purposes
  Map<String, dynamic> get toMap => <String, dynamic>{
        'width': size.width,
        'height': size.height,
        'rotation': imageRotationToInt(imageRotation),
        'imageFormat': imageFormatToInt(inputImageFormat)
      };
}
