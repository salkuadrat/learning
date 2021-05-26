# ML Selfie Segmentation

The easy way to use ML Kit for selfie segmentation in Flutter.

ML Kit's Selfie Segmentation allows developers to easily separate the background from users within a scene and focus on what matters. Adding cool effects to selfies or inserting your users into interesting background environments has never been easier.

It takes an input image and produces an output mask. By default, the mask will be the same size as the input image. Each pixel of the mask is assigned a float number that has a range between [0.0, 1.0]. The closer the number is to 1.0, the higher the confidence that the pixel represents a person, and vice versa.

It works with static images and live video use cases. During live video, it will leverage output from previous frames to return smoother segmentation results.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_selfie_segmentation/screenshot.png" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_selfie_segmentation
```

or

```yaml
dependencies:
  learning_selfie_segmentation: ^0.0.2
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_selfie_segmentation/learning_selfie_segmentation.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for selfie segmentation.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Selfie Segmentation',
  onImage: (InputImage image) {
    // now we can feed the input image into selfie segmenter
  },
)
```

### Selfie Segmentation

After getting the `InputImage`, we can start doing selfie segmentation by calling method `process` from an instance of `SelfieSegmenter`.

```dart
SelfieSegmenter segmenter = SelfieSegmenter();
SegmentationMask? mask = await segmenter.process(image);
```

`SelfieSegmenter` is instantiated with default parameters as following.

```dart
SelfieSegmenter segmenter = SelfieSegmenter(
  isStream: true,
  enableRawSizeMask: false,
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
    <td>true</td>
  </tr>
  <tr>
    <td>enableRawSizeMask</td>
    <td>false / true</td>
    <td>false</td>
  </tr>
</table>

### Output

The result of selfie segmentation process is a `SegmentationMask` object that contains the following data.

```dart
int width; // width of segmented mask
int height; // height of segmented mask
List confidences // list of values representing the confidence of the pixel in the mask being in the foreground
```

### Segmentation Mask Painting

To make it easy to paint from `SegmentationMask` to the screen, we provide `SegmentationOverlay` which you can pass to parameter `overlay` of `InputCameraView`. For more detail about how to use this painting, you can see at the [working example code here](example/lib/main.dart).

```dart
SegmentationOverlay(
  size: size,
  originalSize: originalSize,
  rotation: rotation,
  mask: segmentationMask,
)
```

### Dispose

```dart
segmenter.dispose();
```

## Example Project

You can learn more from example project [here](example).
