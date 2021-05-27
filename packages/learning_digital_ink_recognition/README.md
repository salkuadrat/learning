# ML Digital Ink Recognition

The easy way to use ML Kit for digital ink recognition in Flutter.

With ML Kit's Digital Ink Recognition, we can recognize handwritten text on a digital surface in hundreds of languages, as well as classify sketches. It uses the same technology that powers handwriting recognition in Gboard, Google Translate, and the Quick, Draw! game.

Digital Ink Recognition makes it possible to write on the screen instead of typing on a virtual keyboard. This lets users draw characters that are not available on their keyboard, such as ệ, अ or 森 for latin alphabet keyboards. It can also transcribe handwritten notes and recognize hand‑drawn shapes and emojis.

Digital Ink Recognition works with the strokes the user draws on the screen, and works fully offline. If you need to read text from images taken with the camera, please use `learning_text_recognition`.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_digital_ink_recognition/screenshot.png" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_digital_ink_recognition
```

or

```yaml
dependencies:
  learning_digital_ink_recognition: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
```

### Initialization 

Before using digital ink recognition, we need to define the recognition object with the model we want to use.

```dart
DigitalInkRecognition recognition = DigitalInkRecognition(model: 'en-US');
```

For a complete list of base models supported by digital ink recognition, please [read here](https://developers.google.com/ml-kit/vision/digital-ink-recognition/base-models).

Then we need to initialize the recognition object by passing writingArea to the start method. Make sure the width and height we pass to writingArea is the correct width / height of our canvas.

```dart
await recognition.start(writingArea: Size(width, height));
```

We also need to ensure the availability of digital ink recognition model that we want to use.

```dart
// model is a string value, e.g. 'en-US'
bool isDownloaded = await DigitalInkModelManager.isDownloaded(model);

// download the model first if it's not downloaded yet
if (!isDownloaded) {
  await DigitalInkModelManager.download(model);
}
```

### Gesture Detection

The cycle of digital ink recognition start by detecting movement on our canvas. It can be done by using `onScaleStart`, `onScaleUpdate`, and `onScaleEnd` from `GestureDetector` widget.

When the user start writing on canvas, it wil trigger `onScaleStart` which includes data about the touching position that we need to pass to digital ink recognition.

```dart
// send Offset point from onScaleStart to method actionDown
await recognition.actionDown(point);
```

Then the user continue writing on canvas, and it is detected by `onScaleUpdate` that also contains data about the touching point. We should pass this point again to digital ink recognition.

```dart
// send Offset point from onScaleUpdate to method actionMove
await recognition.actionMove(point);
```

And then when the user stop touching the screen, it will trigger `onScaleEnd` which is the cue to call `actionUp` to inform digital ink recognition that the user has stopped writing.

```dart
await recognition.actionUp();
```

The cycle of calling `actionDown`, `actionMove` and `actionUp` can continues several times before we start the process of digital ink recognition.

### Digital Ink Recognition

After every stroke that the user do on our canvas is recorded, we can start the process of digital ink recognition by calling method `process`.

```dart
List<RecognitionCandidate> result = await recognition.process();
```

It's always good practice to ensure the availability of our model again before it is used.

```dart
// model is a string value, e.g. 'en-US'
bool isDownloaded = await DigitalInkModelManager.isDownloaded(model);

// download the model first if it's not downloaded yet
if (!isDownloaded) {
  await DigitalInkModelManager.download(model);
}

List<RecognitionCandidate> result = await recognition.process();
```

### Output

The output of digital ink recognition process is a list of `RecognitionCandidate` object which contains data as follows.

```dart
String text
double? score
```

The `RecognitionCandidate` data inside the list is already sorted by its score, so we can always pick the first one as the most possible candidate for the answer.

### Dispose

```dart
recognition.dispose();
```

## Example Project

You can learn more from example project [here](example).
