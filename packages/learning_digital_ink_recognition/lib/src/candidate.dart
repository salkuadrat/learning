class RecognitionCandidate {
  final String text;
  final double? score;

  RecognitionCandidate({
    required this.text,
    this.score,
  });
  
  factory RecognitionCandidate.from(Map json) => RecognitionCandidate(
        text: json['text'] as String,
        score: json['score'] != null ? json['score'] as double : null,
      );
}
