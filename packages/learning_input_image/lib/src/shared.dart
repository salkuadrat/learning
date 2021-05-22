import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

enum InputImageFormat { NV21, YV12, YUV_420_888 }

enum InputImageRotation { ROTATION_0, ROTATION_90, ROTATION_180, ROTATION_270 }

/// Convert enum [InputImageFormat] to it's corresponding integer value.
///
/// Source: https://developers.google.com/android/reference/com/google/mlkit/vision/common/InputImage#constants
int imageFormatToInt(InputImageFormat inputImageFormat) {
  switch (inputImageFormat) {
    case InputImageFormat.NV21:
      return 17;
    case InputImageFormat.YV12:
      return 842094169;
    case InputImageFormat.YUV_420_888:
      return 35;
    default:
      return 17;
  }
}

/// Convert enum [InputImageRotation] to integer value.
int imageRotationToInt(InputImageRotation? inputImageRotation) {
  switch (inputImageRotation) {
    case InputImageRotation.ROTATION_0:
      return 0;
    case InputImageRotation.ROTATION_90:
      return 90;
    case InputImageRotation.ROTATION_180:
      return 180;
    case InputImageRotation.ROTATION_270:
      return 270;
    default:
      return 0;
  }
}
