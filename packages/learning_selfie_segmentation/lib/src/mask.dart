class SegmentationMask {
  final int width;
  final int height;
  final List confidences;

  SegmentationMask({
    required this.width,
    required this.height,
    this.confidences = const [],
  });

  factory SegmentationMask.from(Map json) => SegmentationMask(
        width: json['maskWidth'] as int,
        height: json['maskHeight'] as int,
        confidences: json['confidences'],
      );
}
