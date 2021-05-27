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

### Gesture Detection

### Digital Ink Recognition

### Output

### Dispose

```dart
recognition.dispose();
```

## Example Project

You can learn more from example project [here](example).
