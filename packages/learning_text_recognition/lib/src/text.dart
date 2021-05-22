import 'dart:ui';

class MLText {
  final String text;
  final List<MLTextBlock> blocks;

  MLText({required this.text, this.blocks = const []});

  factory MLText.from(Map<String, dynamic> json) => MLText(
        text: json['text'],
        blocks: toBlocks(json['blocks'] as List<Map<String, dynamic>>),
      );
}

class MLTextBlock {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;
  final List<MLTextLine> lines;

  MLTextBlock({
    required this.text,
    this.language,
    this.cornerPoints = const [],
    this.frame,
    this.lines = const [],
  });

  factory MLTextBlock.from(Map<String, dynamic> json) => MLTextBlock(
        text: json['text'],
        language: json['language'],
        cornerPoints:
            toPoints(json['cornerPoints'] as List<Map<String, dynamic>>),
        frame: toRect(json['frame']),
        lines: toLines(json['lines']),
      );
}

class MLTextLine {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;
  final List<MLTextElement> elements;

  MLTextLine({
    required this.text,
    this.language,
    this.cornerPoints = const [],
    this.frame,
    this.elements = const [],
  });

  factory MLTextLine.from(Map<String, dynamic> json) => MLTextLine(
        text: json['text'],
        language: json['language'],
        cornerPoints:
            toPoints(json['cornerPoints'] as List<Map<String, dynamic>>),
        frame: toRect(json['frame']),
        elements: toElements(json['elements']),
      );
}

class MLTextElement {
  final String text;
  final String? language;
  final List<Offset> cornerPoints;
  final Rect? frame;

  MLTextElement(
      {required this.text,
      this.language,
      this.cornerPoints = const [],
      this.frame});

  factory MLTextElement.from(Map<String, dynamic> json) => MLTextElement(
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

List<MLTextElement> toElements(List<Map<String, dynamic>> elements) {
  List<MLTextElement> result = [];

  for (var element in elements) {
    result.add(MLTextElement.from(element));
  }

  return result;
}

List<MLTextLine> toLines(List<Map<String, dynamic>> lines) {
  List<MLTextLine> result = [];

  for (var line in lines) {
    result.add(MLTextLine.from(line));
  }

  return result;
}

List<MLTextBlock> toBlocks(List<Map<String, dynamic>> blocks) {
  List<MLTextBlock> result = [];

  for (var block in blocks) {
    result.add(MLTextBlock.from(block));
  }

  return result;
}
