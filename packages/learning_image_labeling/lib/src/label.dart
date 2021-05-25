class Label {
  int index;
  String label;
  double confidence;

  Label({
    required this.index,
    required this.label,
    this.confidence = 0.0,
  });

  factory Label.from(Map json) => Label(
        index: json['index'] as int,
        label: json['label'] as String,
        confidence: json['confidence'] as double,
      );
}
