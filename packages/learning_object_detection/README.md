# ML Object Detection & Tracking

The easy way to use ML Kit for object detection & tracking in Flutter.

With ML Kit's on-device object detection and tracking, we can detect and track objects in an image or live camera feed. Optionally, we can classify detected objects, either by using the built-in coarse classifier, or using custom image classification model.

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
ObjectDetector detector = ObjectDetector();
List<DetectedObject> result = await detector.detect(image);
```

`ObjectDetector` is instantiated with default parameters as following.

```dart
ObjectDetector detector = ObjectDetector(
  isStream: false,
  enableClassification: true,
  enableMultipleObjects: true,
)
```

But we can override this by passing other values.

<table>
  <tr>
    <th>Parameter</th>
    <th>Value</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>isStream</td>
    <td>false / true</td>
    <td>false</td>
  </tr>
  <tr>
    <td>enableClassification</td>
    <td>false / true</td>
    <td>true</td>
  </tr>
  <tr>
    <td>enableMultipleObjects</td>
    <td>false, true</td>
    <td>true</td>
  </tr>
</table>

### Output

The result of face detection process is a list of `DetectedObject`, in each contains the following.

```dart
int? trackingId // Tracking ID of the object. The value is null when isStream is false.
Rect boundingBox // showing the rectangle of the detected object
List<DetectedLabel> labels // the list of possible labels for the detected object
```

Each object of `DetectedLabel` contains the following data.

```dart
int index // index of this label
String label // the label of the object
double confidence // the value representing the probability that the label is correct
```

### Object Painting

To make it easy to paint from `DetectedObject` to the screen, we provide `ObjectOverlay` which you can pass to parameter `overlay` of `InputCameraView`. For more detail about how to use this painting, you can see at the [working example code here](example/lib/main.dart).

```dart
ObjectOverlay(
  size: size,
  originalSize: originalSize,
  rotation: rotation,
  objects: objects,
)
```

### Dispose

```dart
detector.dispose();
```

## Example Project

You can learn more from example project [here](example).
