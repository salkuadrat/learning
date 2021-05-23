# Learning Text Recognition

The easy way to use ML Kit for text recognition in Flutter.

ML Kit's text recognition can recognize text in any Latin-based character set. They can also be used to automate data-entry tasks such as processing credit cards, receipts, and business cards.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_text_recognition
```

or

```yaml
dependencies:
  learning_text_recognition: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_text_recognition/learning_text_recognition.dart';
```

### Input Image



### Text Recognition

When we have prepared the input image, we can start processing text recognition by calling method `process` from an instance of `TextRecognition`.

```dart
TextRecognition textRecognition = TextRecognition();
RecognizedText result = await textRecognition.process(image);
```

### Output

The result of text recognition process is a `RecognizedText` variable that contains nested elements describing the details of the recognized text from input image.

Here is example of structure data inside `RecognizedText`.

<table>
  <tr>
    <th colspan="2">RecognizedText</td>
  </tr>
  <tr>
    <td>text</td>
    <td>Wege der parlamentarischen Demokratie</td>
  </tr>
  <tr>
    <td>blocks</td>
    <td>(1 block)</td>
  </tr>
</table>

### Dispose

```dart
textRecognition.dispose();
```