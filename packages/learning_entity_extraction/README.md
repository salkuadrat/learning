# ML Entity Extraction

The easy way to use ML Kit for entity extraction in Flutter.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_entity_extraction
```

or

```yaml
dependencies:
  learning_entity_extraction: ^0.0.1
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_entity_extraction/learning_entity_extraction.dart';
```

### Extracting Entities

```dart
EntityExtractor extractor = EntityExtractor();
List result = await extractor.extract(text);
print(result);
```

### Dispose

```dart
extractor.dispose();
```

### Entity Model Management

Get list of downloaded entity models.

```dart
var models = await EntityModelManager.list();
print(models);
```

Download entity model.

```dart
await EntityModelManager.download(ENGLISH);
```

Check availability of entity model (downloaded or not).

```dart
// exist will true if the model is already downloaded before
var exist = await EntityModelManager.check(ENGLISH);
print('Check model: $exist');    
```

Delete entity model.

```dart
await EntityModelManager.delete(ENGLISH);
```

## Example Project

You can learn more from example project [here](example).