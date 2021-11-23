enum TextRecognitionOptions {
  Default,
  Chinese,
  Devanagari,
  Japanese,
  Korean,
}

String fromOptions(TextRecognitionOptions options) {
  switch (options) {
    case TextRecognitionOptions.Chinese:
      return 'chinese';
    case TextRecognitionOptions.Devanagari:
      return 'devanagari';
    case TextRecognitionOptions.Japanese:
      return 'japanese';
    case TextRecognitionOptions.Korean:
      return 'korean';
    default:
      return 'default';
  }
}
