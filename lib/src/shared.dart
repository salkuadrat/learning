import 'package:flutter/services.dart';

MethodChannel channel = MethodChannel('Learning');

class Language {
  static const AFRIKAANS = "af";
  static const ALBANIAN = "sq";
  static const ARABIC = "ar";
  static const BELARUSIAN = "be";
  static const BENGALI = "bn";
  static const BULGARIAN = "bg";
  static const CATALAN = "ca";
  static const CHINESE = "zh";
  static const CROATIAN = "hr";
  static const CZECH = "cs";
  static const DANISH = "da";
  static const DUTCH = "nl";
  static const ENGLISH = "en";
  static const ESPERANTO = "eo";
  static const ESTONIAN = "et";
  static const FINNISH = "fi";
  static const FRENCH = "fr";
  static const GALICIAN = "gl";
  static const GEORGIAN = "ka";
  static const GERMAN = "de";
  static const GREEK = "el";
  static const GUJARATI = "gu";
  static const HAITIAN_CREOLE = "ht";
  static const HEBREW = "he";
  static const HINDI = "hi";
  static const HUNGARIAN = "hu";
  static const ICELANDIC = "is";
  static const INDONESIAN = "id";
  static const IRISH = "ga";
  static const ITALIAN = "it";
  static const JAPANESE = "ja";
  static const KANNADA = "kn";
  static const KOREAN = "ko";
  static const LATVIAN = "lv";
  static const LITHUANIAN = "lt";
  static const MACEDONIAN = "mk";
  static const MALAY = "ms";
  static const MALTESE = "mt";
  static const MARATHI = "mr";
  static const NORWEGIAN = "no";
  static const PERSIAN = "fa";
  static const POLISH = "pl";
  static const PORTUGUESE = "pt";
  static const ROMANIAN = "ro";
  static const RUSSIAN = "ru";
  static const SLOVAK = "sk";
  static const SLOVENIAN = "sl";
  static const SPANISH = "es";
  static const SWAHILI = "sw";
  static const SWEDISH = "sv";
  static const TAGALOG = "tl";
  static const TAMIL = "ta";
  static const TELUGU = "te";
  static const THAI = "th";
  static const TURKISH = "tr";
  static const UKRAINIAN = "uk";
  static const URDU = "ur";
  static const VIETNAMESE = "vi";
  static const WELSH = "cy";
}

enum InputImageFormat { NV21, YV12, YUV_420_888 }

enum InputImageRotation {
  Rotation_0deg,
  Rotation_90deg,
  Rotation_180deg,
  Rotation_270deg
}

enum EntityType {
  DATE_TIME,
  FLIGHT_NUMBER,
  MONEY,
  IBAN,
  ISBN,
  PAYMENT_CARD,
  TRACKING_NUMBER,
  UNKNOWN,
}

/// Convert enum [InputImageFormat] to it's corresponding integer value.
///
/// Source: https://developers.google.com/android/reference/com/google/mlkit/vision/common/InputImage#constants
int imageFormatToInt(InputImageFormat inputImageFormat) {
  switch (inputImageFormat) {
    case InputImageFormat.NV21:
      return 17;
    case InputImageFormat.YV12:
      return 842094169;
    case InputImageFormat.YUV_420_888:
      return 35;
    default:
      return 17;
  }
}

/// Convert enum [InputImageRotation] to integer value.
int imageRotationToInt(InputImageRotation? inputImageRotation) {
  switch (inputImageRotation) {
    case InputImageRotation.Rotation_0deg:
      return 0;
    case InputImageRotation.Rotation_90deg:
      return 90;
    case InputImageRotation.Rotation_180deg:
      return 180;
    case InputImageRotation.Rotation_270deg:
      return 270;
    default:
      return 0;
  }
}

/// Convert entity type [String] to enum [EntityType]
EntityType stringToEntityType(String type) {
  switch (type) {
    case 'datetime':
      return EntityType.DATE_TIME;
    case 'flight':
      return EntityType.FLIGHT_NUMBER;
    case 'money':
      return EntityType.MONEY;
    case 'iban':
      return EntityType.IBAN;
    case 'isbn':
      return EntityType.ISBN;
    case 'payment':
      return EntityType.PAYMENT_CARD;
    case 'tracking':
      return EntityType.TRACKING_NUMBER;
    default:
      return EntityType.UNKNOWN;
  }
}
