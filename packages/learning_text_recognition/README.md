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

The result of text recognition is a `RecognizedText` variable that contains nested elements describing the details of the recognized text from input image. Here is example of structure data inside `RecognizedText`.

<table>
  <tr>
    <th colspan="2">RecognizedText</td>
  </tr>
  <tr>
    <td>Text</td>
    <td>
      Wege<br>
      der parlamentarischen<br>
      Demokratie
    </td>
  </tr>
  <tr>
    <td>Blocks</td>
    <td>(1 block)</td>
  </tr>
</table>

<table>
  <tr>
    <th colspan="2">Block 0</td>
  </tr>
  <tr>
    <td>Text</td>
    <td>Wege der parlamentarischen Demokratie</td>
  </tr>
  <tr>
    <td>Frame</td>
    <td>(117.0, 258.0, 190.0, 83.0)</td>
  </tr>
  <tr>
    <td>Corner Points</td>
    <td>(117, 270), (301.64, 258.49), (306.05, 329.36), (121.41, 340.86)</td>
  </tr>
  <tr>
    <td>Recognized Language Code</td>
    <td>de</td>
  </tr>
  <tr>
    <td>Lines</td>
    <td>(3 lines)</td>
  </tr>
</table>

<table>
  <tr>
    <th colspan="2">Line 0</td>
  </tr>
  <tr>
    <td>Text</td>
    <td>Wege der</td>
  </tr>
  <tr>
    <td>Frame</td>
    <td>(167.0, 261.0, 91.0, 28.0)</td>
  </tr>
  <tr>
    <td>Corner Points</td>
    <td>(167, 267), (255.82, 261.46), (257.19, 283.42), (168.36, 288.95)
</td>
  </tr>
  <tr>
    <td>Recognized Language Code</td>
    <td>de</td>
  </tr>
  <tr>
    <td>Elements</td>
    <td>(2 elements)</td>
  </tr>
</table>

<table>
  <tr>
    <th colspan="2">Element 0</td>
  </tr>
  <tr>
    <td>Text</td>
    <td>Wege</td>
  </tr>
  <tr>
    <td>Frame</td>
    <td>(167.0, 263.0, 59.0, 26.0)</td>
  </tr>
  <tr>
    <td>Corner Points</td>
    <td>(167, 267), (223.88, 263.45), (225.25, 285.41), (168.36, 288.95)
</td>
  </tr>
</table>

### Dispose

```dart
textRecognition.dispose();
```