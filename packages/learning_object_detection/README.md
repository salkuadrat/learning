# ML Object Detection & Tracking

The easy way to use ML Kit for object detection & tracking in Flutter.

With ML Kit's on-device object detection and tracking, we can detect and track objects in an image or live camera feed. Optionally, we can classify detected objects, either by using the built-in coarse classifier, or using your own custom image classification model.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_object_detection/screenshot.jpg" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_object_detection
```

or

```yaml
dependencies:
  learning_object_detection: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_object_detection/learning_object_detection.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for object detection & tracking.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Object Detection & Tracking',
  onImage: (InputImage image) {
    // now we can feed the input image into object detector
  },
)
```

### Object Detection

After getting the `InputImage`, we can start detecting objetcs by calling method `detect` from an instance of `ObjectDetector`.

```dart
ObjectDetector detector = ObjectDetector(
  isStream: false,
  enableClassification: true,
  enableMultipleObjects: true,
);

List<DetectedObject> result = await detector.detect(image);
```

