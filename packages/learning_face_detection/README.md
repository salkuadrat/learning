# ML Face Detection

The easy way to use ML Kit for face detection in Flutter.

With ML Kit's face detection, we can detect faces in an image, identify key facial features, and get the contours of detected faces. Note: it's only detecting faces, not recognizing people.

With face detection, we can get the information to perform tasks like embellishing selfies and portraits, or generating avatars from user's photo. Because it can perform face detection in real time, we can use it in applications like video chat, games, or TikTok that respond to user's expressions.

To get a starting grasp about the process of face detection, including landmarks, contours, and classification. Please read first [Face Detection Concepts](https://developers.google.com/ml-kit/vision/face-detection/face-detection-concepts) described in [here](https://developers.google.com/ml-kit/vision/face-detection/face-detection-concepts).

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_face_detection/screenshot.jpg" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_face_detection
```

or

```yaml
dependencies:
  learning_face_detection: ^0.0.2
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
    // now we can feed the input image into face detector
  },
)
```

### Face Detection

After getting the `InputImage`, we can start detecting faces by calling method `detect` from an instance of `FaceDetector`.

```dart
FaceDetector detector = FaceDetector();
List<Face> result = await detector.detect(image);
```

`FaceDetector` is instantiated with default parameters as following.

```dart
FaceDetector detector = FaceDetector(
  mode: FaceDetectorMode.fast,
  detectLandmark: true,
  detectContour: true,
  enableClassification: false,
  enableTracking: false,
  minFaceSize: 0.15,
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
    <td>mode</td>
    <td>FaceDetectorMode.fast / FaceDetectorMode.accurate</td>
    <td>FaceDetectorMode.fast</td>
  </tr>
  <tr>
    <td>detectLandmark</td>
    <td>false / true</td>
    <td>false</td>
  </tr>
  <tr>
    <td>detectContour</td>
    <td>false / true</td>
    <td>false</td>
  </tr>
  <tr>
    <td>enableClassification</td>
    <td>false / true</td>
    <td>false</td>
  </tr>
  <tr>
    <td>enableTracking</td>
    <td>false, true</td>
    <td>false</td>
  </tr>
  <tr>
    <td>minFaceSize</td>
    <td>Any value between 0.0 and 1.0</td>
    <td>0.15</td>
  </tr>
</table>

### Output

The result of face detection process is a list of `Face` object, in each contains the following.

```dart
Rect boundingBox // showing the rectangle of the detected face

double headAngleY // Head is rotated to the right at headAngleY degrees

double headAngleZ // Head is tilted sideways at headAngleZ degrees

int? trackingId // Tracking ID

double? smilingProbability // the probability that the face is smiling

double? leftEyeOpenProbability // the probability that the left eye is open

double? rightEyeOpenProbability // the probability that the right eye is open

Map<FaceLandmarkType, FaceLandmark> landmarks // Map object representing the list of FaceLandmark

Map<FaceContourType, FaceContour> countours // Map object representing the list of FaceContour

```

The object of `FaceLandmark` contains two kinds of information: type and point.

```dart
FaceLandmarkType type
Offset point
```

Here is the list of `FaceLandmarkType`:

```dart
LEFT_EYE
RIGHT_EYE
LEFT_EAR
RIGHT_EAR
LEFT_CHEEK
RIGHT_CHEEK
NOSE_BASE
MOUTH_LEFT
MOUTH_RIGHT
MOUTH_BOTTOM
```

Each instance of `FaceContour` contains two information: type and points.

```dart
FaceContourType type
List<Offset> points
```

Here is the list of `FaceContourType`:

```dart
FACE
LEFT_EYE
RIGHT_EYE
LEFT_EYEBROW_TOP
LEFT_EYEBROW_BOTTOM
RIGHT_EYEBROW_TOP
RIGHT_EYEBROW_BOTTOM
NOSE_BRIDGE
NOSE_BOTTOM
LEFT_CHEEK
RIGHT_CHEEK
UPPER_LIP_TOP
UPPER_LIP_BOTTOM
LOWER_LIP_TOP
LOWER_LIP_BOTTOM
```

### Face Painting

To make it easy to paint from `Face` object to the screen, we provide `FaceOverlay` which you can pass to parameter `overlay` of `InputCameraView`. For more detail about how to use this painting, you can see at the [working example code here](example/lib/main.dart).

```dart
FaceOverlay(
  size: size,
  originalSize: originalSize,
  rotation: rotation,
  faces: faces,
  contourColor: Colors.white.withOpacity(0.8),
  landmarkColor: Colors.lightBlue.withOpacity(0.8),
)
```

### Dispose

```dart
detector.dispose();
```

## Example Project

You can learn more from example project [here](example).
