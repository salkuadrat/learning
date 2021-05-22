# ML Language

The easy way to use ML Kit for identifying languages in Flutter.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_language
```

or

```yaml
dependencies:
  learning_language: ^0.0.1
```

Then run `flutter pub get`.

## Usage

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

print('Possible Languages:');
print(possibleLanguages);
```

### Dispose

```dart
identifier.dispose();
```

## Example Project

You can learn more from example project [here](example).