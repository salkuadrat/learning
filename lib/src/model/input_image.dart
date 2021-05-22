import 'dart:io';
import 'dart:typed_data';

import 'input_image_data.dart';

///[InputImage] is the format Google' Ml kit takes to process the image
class InputImage {
  final String type;
  final String? path;
  final Uint8List? bytes;
  final InputImageData? metadata;

  InputImage({
    this.path,
    this.bytes,
    required this.type,
    this.metadata,
  });

  ///Create InputImage from File path
  factory InputImage.fromFilePath(String path) {
    return InputImage(type: 'file', path: path);
  }

  ///Create InputImage from File
  factory InputImage.fromFile(File file) {
    return InputImage(type: 'file', path: file.path);
  }

  ///Create InputImage from bytes
  factory InputImage.fromBytes(
      {required Uint8List bytes, required InputImageData metadata}) {
    return InputImage(type: 'bytes', bytes: bytes, metadata: metadata);
  }

  Map<String, dynamic> get toMap => <String, dynamic>{
        'bytes': bytes,
        'type': type,
        'path': path,
        'metadata': metadata?.toMap ?? '{}',
      };
}
