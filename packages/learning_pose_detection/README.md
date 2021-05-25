# ML Pose Detection

The easy way to use ML Kit for pose detection in Flutter.

The ML Kit Pose Detection is a lightweight versatile solution for app developers to detect the pose of user's body in real time from a continuous video or static image. 

A pose describes the body's position at one moment in time with a set of skeletal landmark points. The landmarks correspond to different body parts such as the shoulders and hips. The relative positions of landmarks can be used to distinguish one pose from another. It produces a full-body 33 point skeletal match that includes facial landmarks (ears, eyes, mouth, and nose) and points on the hands and feet. 

ML Kit Pose Detection doesn't require specialized equipment or ML expertise in order to achieve great results. With this technology developers can create one of a kind experiences for their users with only a few lines of code.

The user's face must be present in order to detect a pose. Pose detection works best when the subject’s entire body is visible in the frame, but it also detects a partial body pose. In that case the landmarks that are not recognized are assigned coordinates outside of the image.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_pose_detection/screenshot.jpg" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_pose_detection
```

or

```yaml
dependencies:
  learning_pose_detection: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_pose_detection/learning_pose_detection.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for pose detection.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Pose Detection',
  onImage: (InputImage image) {
    // now we can feed the input image into pose detector
  },
)
```

### Pose Detection

After getting the `InputImage`, we can start detecting user's pose by calling method `detect` from an instance of `PoseDetector`.

```dart
PoseDetector detector = PoseDetector();
Pose? pose = await detector.detect(image);
```

### Output

Output of pose detection process is a `Pose` object which contains the following information.

```dart
Map<PoseLandmarkType, PoseLandmark> landmarks // Map object representing the list of PoseLandmark
```

Each `PoseLandmark` contains the following data.

```dart
PoseLandmarkType type // the type of detected landmark
Offset position // the x, y position of detected landmark
double inFrameLikelihood // the probability of the detected landmark to be inside the frame
```

And here is the list of `PoseLandmarkType` values.

```dart
LEFT_EYE
LEFT_EYE_INNER
LEFT_EYE_OUTER
RIGHT_EYE
RIGHT_EYE_INNER
RIGHT_EYE_OUTER
LEFT_EAR
RIGHT_EAR
NOSE
LEFT_MOUTH
RIGHT_MOUTH
LEFT_SHOULDER
RIGHT_SHOULDER
LEFT_ELBOW
RIGHT_ELBOW
LEFT_WRIST
RIGHT_WRIST
LEFT_THUMB
RIGHT_THUMB
LEFT_INDEX
RIGHT_INDEX
LEFT_PINKY
RIGHT_PINKY
LEFT_HIP
RIGHT_HIP
LEFT_KNEE
RIGHT_KNEE
LEFT_ANKLE
RIGHT_ANKLE
LEFT_HEEL
RIGHT_HEEL
LEFT_FOOT_INDEX
RIGHT_FOOT_INDEX
```

### Pose Painting

To make it easy to paint from `Pose` object to the screen, we provide `PoseOverlay` which you can pass to parameter `overlay` of `InputCameraView`. For more detail about how to use this painting, you can see at the [working example code here](example/lib/main.dart).

```dart
PoseOverlay(
  size: size,
  originalSize: originalSize,
  rotation: rotation,
  pose: pose,
)
```

### Dispose

```dart
detector.dispose();
```

## Example Project

You can learn more from example project [here](example).
