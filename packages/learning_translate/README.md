# ML Translate

The easy way to use ML Kit for on-device text translation in Flutter. With ML Kit's on-device Translation, you can dynamically translate text between more than 50 languages.

## Limitations

On-device translation is intended for casual and simple translations. The translation quality depends on the source and target languages. We recommend that you evaluate the quality of the translations for your specific use case. 

Also, ML Kit's translation models are trained to translate to and from English. When you translate between non-English languages, English is used as an intermediate translation, which can affect quality.

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

### Supported Languages

Here is constant language variables you can use in learning_translate.

```dart
const AFRIKAANS = "af";
const ALBANIAN = "sq";
const ARABIC = "ar";
const BELARUSIAN = "be";
const BENGALI = "bn";
const BULGARIAN = "bg";
const CATALAN = "ca";
const CHINESE = "zh";
const CROATIAN = "hr";
const CZECH = "cs";
const DANISH = "da";
const DUTCH = "nl";
const ENGLISH = "en";
const ESPERANTO = "eo";
const ESTONIAN = "et";
const FINNISH = "fi";
const FRENCH = "fr";
const GALICIAN = "gl";
const GEORGIAN = "ka";
const GERMAN = "de";
const GREEK = "el";
const GUJARATI = "gu";
const HAITIAN_CREOLE = "ht";
const HEBREW = "he";
const HINDI = "hi";
const HUNGARIAN = "hu";
const ICELANDIC = "is";
const INDONESIAN = "id";
const IRISH = "ga";
const ITALIAN = "it";
const JAPANESE = "ja";
const KANNADA = "kn";
const KOREAN = "ko";
const LATVIAN = "lv";
const LITHUANIAN = "lt";
const MACEDONIAN = "mk";
const MALAY = "ms";
const MALTESE = "mt";
const MARATHI = "mr";
const NORWEGIAN = "no";
const PERSIAN = "fa";
const POLISH = "pl";
const PORTUGUESE = "pt";
const ROMANIAN = "ro";
const RUSSIAN = "ru";
const SLOVAK = "sk";
const SLOVENIAN = "sl";
const SPANISH = "es";
const SWAHILI = "sw";
const SWEDISH = "sv";
const TAGALOG = "tl";
const TAMIL = "ta";
const TELUGU = "te";
const THAI = "th";
const TURKISH = "tr";
const UKRAINIAN = "uk";
const URDU = "ur";
const VIETNAMESE = "vi";
const WELSH = "cy";
```

## Example Project

You can learn more from example project [here](example).