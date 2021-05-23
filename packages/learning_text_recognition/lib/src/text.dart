import 'dart:ui';

class RecognizedText {
  final String text;
  final List<TextBlock> blocks;

  RecognizedText({required this.text, this.blocks = const []});

  factory RecognizedText.from(Map json) => RecognizedText(
        text: json['text'] as String,
        blocks: toBlocks(json['blocks']),
      );

  @override
  String toString() {
    return '<RecognizedText: $text, $blocks>';
  }
}

class TextBlock {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;
  final List<TextLine> lines;

  TextBlock({
    required this.text,
    this.language,
    this.cornerPoints = const [],
    this.frame,
    this.lines = const [],
  });

  factory TextBlock.from(Map json) => TextBlock(
        text: json['text'] as String,
        language: json['language'] as String,
        cornerPoints: toPoints(json['cornerPoints']),
        frame: toRect(json['frame']),
        lines: toLines(json['lines']),
      );

  @override
  String toString() {
    return '<TextBlock: $text, $language, $cornerPoints, $frame, $lines>';
  }
}

class TextLine {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;
  final List<TextElement> elements;

  TextLine({
    required this.text,
    this.language,
    this.cornerPoints = const [],
    this.frame,
    this.elements = const [],
  });

  factory TextLine.from(Map json) => TextLine(
        text: json['text'] as String,
        language: json['language'] as String,
        cornerPoints: toPoints(json['cornerPoints']),
        frame: toRect(json['frame']),
        elements: toElements(json['elements']),
      );

  @override
  String toString() {
    return '<TextLine: $text, $language, $cornerPoints, $frame, $elements>';
  }
}

class TextElement {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;

  TextElement(
      {required this.text,
      this.language,
      this.cornerPoints = const [],
      this.frame});

  factory TextElement.from(Map json) => TextElement(
        text: json['text'] as String,
        language: json['language'] as String,
        cornerPoints: toPoints(json['cornerPoints']),
        frame: toRect(json['frame']),
      );

  @override
  String toString() {
    return '<TextElement: $text, $language, $cornerPoints, $frame>';
  }
}

Rect toRect(Map json) => Rect.fromLTRB(
      (json['left'] as int).toDouble(),
      (json['top'] as int).toDouble(),
      (json['right'] as int).toDouble(),
      (json['right'] as int).toDouble(),
    );

Offset toPoint(Map json) => Offset(
      (json['x'] as int).toDouble(),
      (json['y'] as int).toDouble(),
    );

List<Offset> toPoints(List points) {
  List<Offset> result = [];

  for (var point in points) {
    result.add(toPoint(point));
  }

  return result;
}

List<TextElement> toElements(List elements) {
  List<TextElement> result = [];

  for (var element in elements) {
    result.add(TextElement.from(element));
  }

  return result;
}

List<TextLine> toLines(List lines) {
  List<TextLine> result = [];

  for (var line in lines) {
    result.add(TextLine.from(line));
  }

  return result;
}

List<TextBlock> toBlocks(List blocks) {
  List<TextBlock> result = [];

  for (var block in blocks) {
    result.add(TextBlock.from(block));
  }

  return result;
}
