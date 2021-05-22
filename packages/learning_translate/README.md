# ML Translate

The easy way to use ML Kit for on-device text translation in Flutter.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_translate
```

or

```yaml
dependencies:
  learning_translate: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_translate/learning_translate.dart';
```

### Translate Text

```dart
String text = 'Baby, you light up my world like nobody else';
Translator translator = Translator(from: ENGLISH, to: INDONESIAN);
String result = await translator.translate(text);
print(result);
```

### Dispose

```dart
translator.dispose();
```

### Translation Model Management

Get list of downloaded translation models.

```dart
var models = await TranslationModelManager.list();
print(models);
```

Download a translation model.

```dart
await TranslationModelManager.download(KOREAN);
```

Check availability of a translation model (downloaded or not).

```dart
// exist will true if the model is already downloaded before
var exist = await TranslationModelManager.check(KOREAN);
print('Check model: $exist');    
```

Delete a translation model.

```dart
await TranslationModelManager.delete(KOREAN);
```

## Example Project

You can learn more from example project [here](example).