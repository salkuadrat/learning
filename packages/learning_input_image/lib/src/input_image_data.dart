import 'package:flutter/rendering.dart';

import 'shared.dart';

///Image metadata used when creating image from bytes.
class InputImageData {
  ///Size of image
  final Size size;

  ///Image rotation
  final InputImageRotation rotation;

  ///Input image format
  final InputImageFormat format;

  InputImageData(
      {required this.size,
      this.rotation = InputImageRotation.ROTATION_0,
      this.format = InputImageFormat.NV21});

  ///Function to get the metadata of image processing purposes
  Map<String, dynamic> get json => <String, dynamic>{
        'width': size.width,
        'height': size.height,
        'rotation': imageRotationToInt(rotation),
        'imageFormat': imageFormatToInt(format)
      };
}
