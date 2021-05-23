# ML Face Detection

The easy way to use ML Kit for face detection in Flutter.

With ML Kit's face detection, we can detect faces in an image, identify key facial features, and get the contours of detected faces. Note: it's only detecting face, not recognizing people.

With face detection, we can get the information to perform tasks like embellishing selfies and portraits, or generating avatars from user's photo. Because it can perform face detection in real time, we can use it in applications like video chat, games, or TikTok that respond to user's expressions.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_face_detection
```

or

```yaml
dependencies:
  learning_face_detection: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_face_detection/learning_face_detection.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for face detection.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Face Detection',
  onImage: (InputImage image) {
    // now we can feed the input image into face detection process
  },
)
```

### Face Detection

After getting the `InputImage`, we can start doing face detection by calling method `detect` from an instance of `FaceDetector`.

```dart
FaceDetector detector = FaceDetector();
final result = await detector.detect(image);
print(result);
```

### Output

