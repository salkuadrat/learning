# ML Entity Extraction

The easy way to use ML Kit for entity extraction in Flutter.

Most apps offer users very little interaction with text beyond the basic cut/copy/paste operations. Entity extraction improves the user experience inside your app by understanding text and allowing you to add helpful shortcuts based on context.

The Entity Extraction allows you to recognize specific entities within static text and while you're typing. Once an entity is identified, you can easily enable different actions for the user based on the entity type.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_entity_extraction/screenshot.jpg" alt="universe" width="280">

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_entity_extraction
```

or

```yaml
dependencies:
  learning_entity_extraction: ^0.0.2
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

### Supported Entities

<table>
  <tr>
    <th>Entity</th>
    <th>Index Type</th>
    <th>Example</th>
  </tr>
  <tr>
    <td>Address</td>
    <td>address</td>
    <td>350 third street, Cambridge MA</td>
  </tr>
  <tr>
    <td>Date-Time</td>
    <td>datetime</td>
    <td>2019/09/29, let's meet tomorrow at 6pm</td>
  </tr>
  <tr>
    <td>Email address</td>
    <td>email</td>
    <td>salkuadrat@gmail.com</td>
  </tr>
  <tr>
    <td>Flight Number (IATA flight codes only)</td>
    <td>flight</td>
    <td>LX37</td>
  </tr>
  <tr>
    <td>IBAN</td>
    <td>iban</td>
    <td>CH52 0483 0000 0000 0000 9</td>
  </tr>
  <tr>
    <td>ISBN (version 13 only)</td>
    <td>isbn</td>
    <td>978-1101904190</td>
  </tr>
  <tr>
    <td>Money/Currency (Arabic numerals only)</td>
    <td>money</td>
    <td>$12, 25 USD</td>
  </tr>
  <tr>
    <td>Payment / Credit Cards</td>
    <td>payment</td>
    <td>4111 1111 1111 1111</td>
  </tr>
  <tr>
    <td>Phone Number</td>
    <td>phone</td>
    <td>(555) 225-3556</td>
  </tr>
  <tr>
    <td>Tracking Number (standardized international formats)</td>
    <td>tracking</td>
    <td>1Z204E380338943508</td>
  </tr>
  <tr>
    <td>URL</td>
    <td>url</td>
    <td>https://github.com/salkuadrat/learning</td>
  </tr>
</table>

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

### Supported Languages

Here is language variables you can use in learning_entity_extraction.

```dart
const ARABIC = 'arabic';
const CHINESE = 'chinese';
const DUTCH = 'dutch';
const ENGLISH = 'english';
const FRENCH = 'french';
const GERMAN = 'german';
const ITALIAN = 'italian';
const JAPANESE = 'japanese';
const KOREAN = 'korean';
const POLISH = 'polish';
const PORTUGUESE = 'portuguese';
const RUSSIAN = 'russian';
const SPANISH = 'spanish';
const THAI = 'thai';
const TURKISH = 'turkish';
```

## Example Project

You can learn more from example project [here](example).