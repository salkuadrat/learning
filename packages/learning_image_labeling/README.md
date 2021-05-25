# ML Image Labeling

The easy way to use ML Kit for image labeling in Flutter.

With ML Kit's image labeling we can detect and extract information about entities in an image across a broad group of categories. The default image labeling model can identify general objects, places, activities, animal species, products, and more.

Note that this is intended for image classification models that describe the full image. For classifying one or more objects in an image, such as shoes or pieces of furniture, plugin `learning_object_detection` may be a better fit.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_image_labeling/screenshot.jpg" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_image_labeling
```

or

```yaml
dependencies:
  learning_image_labeling: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_image_labeling/learning_image_labeling.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for face detection.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Image Labeling',
  onImage: (InputImage image) {
    // now we can feed the input image into image labeling process
  },
)
```

### Image Labeling

After getting the `InputImage`, we can start image labeling by calling method `process` from an instance of `ImageLabeling`.

```dart
ImageLabeling imageLabeling = ImageLabeling();
List<Label> labels = await imageLabeling.process(image);
```

`ImageLabeling` object is instantiated with default parameter `confidenceThreshold` as following.

```dart
ImageLabeling imageLabeling = ImageLabeling(confidenceThreshold: 0.8)
```

But feel free to setup using your own value of `confidenceThreshold`.

### Output

The result of image labeling process is a list of `Label` object, in each contains the following data.

```dart
int index // index of this label
String label // the label of image
double confidence // the value representing the probability that the label is right
```

### Dispose

```dart
imageLabeling.dispose();
```

## Example Project

You can learn more from example project [here](example).
