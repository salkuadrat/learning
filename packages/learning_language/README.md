# ML Language

The easy way to use ML Kit for identifying languages in Flutter.

With ML Kit's on-device language identification, we can determine the language of a string of text. Language identification can be useful when working with user-provided text, which often doesn't come with any language information.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_language
```

or

```yaml
dependencies:
  learning_language: ^0.0.3+2
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_language/learning_language.dart';
```

### Identify Language

```dart
String text = 'Baby, you light up my world like nobody else';
LanguageIdentifier identifier = LanguageIdentifier();
String language = await identifier.identify(text);
print(language);
```

### Identify Possible Languages

```dart
String text = 'Baby, you light up my world like nobody else';
LanguageIdentifier identifier = LanguageIdentifier();
List<IdentifiedLanguage> possibleLanguages = await identifier.idenfityPossibleLanguages(text);

String languages = possibleLanguages.map((item) => item.language).toList().join(', ');

print('Possible Languages: $languages');
```

### Dispose

```dart
identifier.dispose();
```

## Example Project

You can learn more from example project [here](example).