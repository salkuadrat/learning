class RecognitionCandidate {
  final String text;
  final double score;

  RecognitionCandidate({
    required this.text,
    required this.score,
  });

  factory RecognitionCandidate.from(Map json) => RecognitionCandidate(
        text: json['text'] as String,
        score: json['score'] as double,
      );
}
