class IdentifiedLanguage {
  final String language;
  final double confidence;

  IdentifiedLanguage(this.language, this.confidence);

  @override
  String toString() {
    return '<IdentifiedLanguage: $language with confidence ${confidence.toString()}>';
  }
}
