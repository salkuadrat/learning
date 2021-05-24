# Learning Barcode Scanning

The easy way to use ML Kit for barcode scanning in Flutter.

With ML Kit's barcode scanning, we can read data encoded using most standard barcode formats. Barcode scanning happens on-device, and doesn't require a network connection.

Barcodes are a convenient way to pass information from the real world to our application. In particular, when using 2D formats such as QR code, we can encode structured data such as contact information or WiFi network credentials. Because it can automatically recognize and parse this data, the application can respond intelligently when a user scans a barcode.

Supported formats:

Linear formats: Codabar, Code 39, Code 93, Code 128, EAN-8, EAN-13, ITF, UPC-A, UPC-E\
2D formats: Aztec, Data Matrix, PDF417, QR Code

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_barcode_scanning
```

or

```yaml
dependencies:
  learning_barcode_scanning: ^0.0.1
```

Then run `flutter pub get`.

