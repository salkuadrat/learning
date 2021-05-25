import 'package:flutter/rendering.dart';

class DetectedObject {
  final int? trackingId;
  final Rect boundingBox;
  final List<DetectedLabel> labels;

  DetectedObject({
    this.trackingId,
    required this.boundingBox,
    this.labels = const [],
  });

  factory DetectedObject.from(Map json) {
    List<DetectedLabel> labels = [];

    if (json.containsKey('labels')) {
      List jsonLabels = json['labels'];

      for (Map label in jsonLabels) {
        labels.add(DetectedLabel.from(label));
      }
    }

    final trackingId = json['trackingId'];

    return DetectedObject(
      trackingId: trackingId != null ? trackingId as int : null,
      boundingBox: toRect(json['boundingBox']),
      labels: labels,
    );
  }
}

class DetectedLabel {
  final int index;
  final String label;
  final double confidence;

  DetectedLabel({
    required this.index,
    required this.label,
    this.confidence = 0.0,
  });

  factory DetectedLabel.from(Map json) => DetectedLabel(
        index: json['index'] as int,
        label: json['label'] as String,
        confidence: json['confidence'] as double,
      );
}

Rect toRect(Map json) => Rect.fromLTRB(
      (json['left'] as int).toDouble(),
      (json['top'] as int).toDouble(),
      (json['right'] as int).toDouble(),
      (json['right'] as int).toDouble(),
    );
