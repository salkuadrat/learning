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

String formatsToString(List<BarcodeFormat> formats) {
  List<String> strings = [];

  for (BarcodeFormat format in formats) {
    String formatStr = formatToString(format);

    if(formatStr.isNotEmpty) {
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