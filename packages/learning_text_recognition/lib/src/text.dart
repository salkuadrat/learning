import 'dart:ui';

class RecognizedText {
  final String text;
  final List<TextBlock> blocks;

  RecognizedText({required this.text, this.blocks = const []});

  factory RecognizedText.from(Map<String, dynamic> json) => RecognizedText(
        text: json['text'],
        blocks: toBlocks(json['blocks'] as List<Map<String, dynamic>>),
      );
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

  factory TextBlock.from(Map<String, dynamic> json) => TextBlock(
        text: json['text'],
        language: json['language'],
        cornerPoints:
            toPoints(json['cornerPoints'] as List<Map<String, dynamic>>),
        frame: toRect(json['frame']),
        lines: toLines(json['lines']),
      );
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

  factory TextLine.from(Map<String, dynamic> json) => TextLine(
        text: json['text'],
        language: json['language'],
        cornerPoints:
            toPoints(json['cornerPoints'] as List<Map<String, dynamic>>),
        frame: toRect(json['frame']),
        elements: toElements(json['elements']),
      );
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

  factory TextElement.from(Map<String, dynamic> json) => TextElement(
        text: json['text'],
        language: json['language'],
        cornerPoints:
            toPoints(json['cornerPoints'] as List<Map<String, dynamic>>),
        frame: toRect(json['frame']),
      );
}

Rect toRect(Map<String, dynamic> json) => Rect.fromLTRB(
      json['left'] as double,
      json['top'] as double,
      json['right'] as double,
      json['right'] as double,
    );

Offset toPoint(Map<String, dynamic> json) => Offset(
      json['x'] as double,
      json['y'] as double,
    );

List<Offset> toPoints(List<Map<String, dynamic>> points) {
  List<Offset> result = [];

  for (var point in points) {
    result.add(toPoint(point));
  }

  return result;
}

List<TextElement> toElements(List<Map<String, dynamic>> elements) {
  List<TextElement> result = [];

  for (var element in elements) {
    result.add(TextElement.from(element));
  }

  return result;
}

List<TextLine> toLines(List<Map<String, dynamic>> lines) {
  List<TextLine> result = [];

  for (var line in lines) {
    result.add(TextLine.from(line));
  }

  return result;
}

List<TextBlock> toBlocks(List<Map<String, dynamic>> blocks) {
  List<TextBlock> result = [];

  for (var block in blocks) {
    result.add(TextBlock.from(block));
  }

  return result;
}
