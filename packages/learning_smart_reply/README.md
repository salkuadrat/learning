# ML Smart Reply

The easy way to use ML Kit for generating smart replies in Flutter.

With ML Kit's Smart Reply, you can automatically generate relevant replies to messages. Smart Reply helps your users respond to messages quickly, and makes it easier to reply to messages on devices with limited input capabilities.

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_smart_reply
```

or

```yaml
dependencies:
  learning_smart_reply: ^0.0.2
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_smart_reply/learning_smart_reply.dart';
```

### Generating Smart Replies

We can generate smart replies by feeding chat message history to `SmartReplyGenerator`.

```dart
SmartReplyGenerator smartReply = SmartReplyGenerator();

Uuid uuid = Uuid();
String userId = uuid.v4();
int now = DateTime.now().millisecondsSinceEpoch;

List<Message> history = [
  Message('Hi', user: userId, timestamp: now - (60*60*1000)),
  Message('How are you?', timestamp: now - (20*60*1000)),
  Message('I am fine. Thanks.', user: userId, timestamp: now - (10*60*1000)),
];

List result = await _smartReply.generateReplies(history);

print('Result:');
print(result);
```

### Dispose

```dart
smartReply.dispose();
```

## Example Project

You can learn more from example project [here](example).