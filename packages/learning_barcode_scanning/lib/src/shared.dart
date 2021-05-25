import 'dart:ui';

enum BarcodeFormat {
  CODE_128,
  CODE_39,
  CODE_93,
  CODABAR,
  EAN_13,
  EAN_8,
  ITF,
  UPC_A,
  UPC_E,
  QR_CODE,
  PDF417,
  AZTEC,
  DATA_MATRIX
}

enum BarcodeType {
  WIFI,
  URL,
  TEXT,
  SMS,
  EMAIL,
  PHONE,
  CALENDAR_EVENT,
  CONTACT_INFO,
  DRIVER_LICENSE,
  GEO,
  ISBN,
  PRODUCT,
  UNKNOWN,
}

enum BarcodeEmailType {
  WORK,
  HOME,
  UNKNOWN,
}

enum BarcodePhoneType {
  FAX,
  HOME,
  MOBILE,
  WORK,
  UNKNOWN,
}

enum BarcodeWifiType {
  OPEN,
  WEP,
  WPA,
  UNKNOWN,
}

String formatsToString(List<BarcodeFormat> formats) {
  List<String> strings = [];

  for (BarcodeFormat format in formats) {
    String formatStr = formatToString(format);

    if (formatStr.isNotEmpty) {
      strings.add(formatStr);
    }
  }

  return strings.join(',');
}

String formatToString(BarcodeFormat format) {
  switch (format) {
    case BarcodeFormat.CODE_128:
      return 'code128';
    case BarcodeFormat.CODE_39:
      return 'code39';
    case BarcodeFormat.CODE_93:
      return 'code93';
    case BarcodeFormat.CODABAR:
      return 'codabar';
    case BarcodeFormat.EAN_13:
      return 'ean-13';
    case BarcodeFormat.EAN_8:
      return 'ean-8';
    case BarcodeFormat.ITF:
      return 'itf';
    case BarcodeFormat.UPC_A:
      return 'upc-a';
    case BarcodeFormat.UPC_E:
      return 'upc-e';
    case BarcodeFormat.QR_CODE:
      return 'qrcode';
    case BarcodeFormat.PDF417:
      return 'pdf417';
    case BarcodeFormat.AZTEC:
      return 'aztec';
    case BarcodeFormat.DATA_MATRIX:
      return 'matrix';
    default:
      return '';
  }
}

BarcodeType toBarcodeType(String type) {
  switch (type) {
    case 'WIFI':
      return BarcodeType.WIFI;
    case 'URL':
      return BarcodeType.URL;
    case 'TEXT':
      return BarcodeType.TEXT;
    case 'SMS':
      return BarcodeType.SMS;
    case 'EMAIL':
      return BarcodeType.EMAIL;
    case 'PHONE':
      return BarcodeType.PHONE;
    case 'CALENDAR_EVENT':
      return BarcodeType.CALENDAR_EVENT;
    case 'CONTACT_INFO':
      return BarcodeType.CONTACT_INFO;
    case 'DRIVER_LICENSE':
      return BarcodeType.DRIVER_LICENSE;
    case 'GEO':
      return BarcodeType.GEO;
    case 'ISBN':
      return BarcodeType.ISBN;
    case 'PRODUCT':
      return BarcodeType.PRODUCT;
    default:
      return BarcodeType.UNKNOWN;
  }
}

BarcodeEmailType toBarcodeEmailType(String type) {
  switch (type) {
    case 'WORK':
      return BarcodeEmailType.WORK;
    case 'HOME':
      return BarcodeEmailType.HOME;
    default:
      return BarcodeEmailType.UNKNOWN;
  }
}

BarcodePhoneType toBarcodePhoneType(String type) {
  switch (type) {
    case 'FAX':
      return BarcodePhoneType.FAX;
    case 'HOME':
      return BarcodePhoneType.HOME;
    case 'MOBILE':
      return BarcodePhoneType.MOBILE;
    case 'WORK':
      return BarcodePhoneType.WORK;
    default:
      return BarcodePhoneType.UNKNOWN;
  }
}

BarcodeWifiType toBarcodeWifiType(String type) {
  switch (type) {
    case 'OPEN':
      return BarcodeWifiType.OPEN;
    case 'WEP':
      return BarcodeWifiType.WEP;
    case 'WPA':
      return BarcodeWifiType.WPA;
    default:
      return BarcodeWifiType.UNKNOWN;
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
  return points.map((point) => toPoint(point)).toList();
}
