# ML Barcode Scanning

The easy way to use ML Kit for barcode scanning in Flutter.

With ML Kit's barcode scanning, we can read data encoded using most standard barcode formats. Barcode scanning happens on-device, and doesn't require a network connection.

Barcodes are a convenient way to pass information from the real world to our application. In particular, when using 2D formats such as QR code, we can encode structured data such as contact information or WiFi network credentials. Because it can automatically recognize and parse this data, the application can respond intelligently when a user scans a barcode.

<img src="https://github.com/salkuadrat/learning/raw/master/packages/learning_barcode_scanning/screenshot.jpg" alt="universe" width="280">

**Supported formats**

Linear: Codabar, Code 39, Code 93, Code 128, EAN-8, EAN-13, ITF, UPC-A, UPC-E\
2D: Aztec, Data Matrix, PDF417, QR Code

## Getting Started

Add dependency to your flutter project:

```
$ flutter pub add learning_barcode_scanning
```

or

```yaml
dependencies:
  learning_barcode_scanning: ^0.0.2
```

Then run `flutter pub get`.

## Usage

```
import 'package:learning_barcode_scanning/learning_barcode_scanning.dart';
```

### Input Image

As in other ML vision plugins, input is fed as an instance of `InputImage`, which is part of package  `learning_input_image`. 

You can use widget `InputCameraView` from `learning_input_image` as default implementation for processing image (or image stream) from camera / storage into `InputImage` format. But feel free to learn the inside of `InputCameraView` code if you want to create your own custom implementation.

Here is example of using `InputCameraView` to get `InputImage` for barcode scanning.

```dart
import 'package:learning_input_image/learning_input_image.dart';

InputCameraView(
  title: 'Barcode Scanning',
  onImage: (InputImage image) {
    // now we can feed the input image into barcode scanner
  },
)
```

### Barcode Scanning

After getting the `InputImage`, we can start detecting faces by calling method `scan` from an instance of `BarcodeScanner`.

```dart
BarcodeScanner scanner = BarcodeScanner(formats: [
  BarcodeFormat.QR_CODE,
  BarcodeFormat.CODE_128,
  BarcodeFormat.CODE_39,
  BarcodeFormat.CODE_93,
  BarcodeFormat.EAN_13,
  BarcodeFormat.EAN_8,
  BarcodeFormat.ITF,
  BarcodeFormat.UPC_A,
  BarcodeFormat.UPC_E,
  BarcodeFormat.CODABAR,
  BarcodeFormat.DATA_MATRIX,
  BarcodeFormat.PDF417
]);

List result = await scanner.scan(image);
```

### Output 

Output of barcode scanning process is a list of `Barcode` object, which is divided into many subclasses depending of its type.

Here is a general data contains within a `Barcode` object.

```dart
BarcodeType type // type of the Barcode object
String value // the raw value inside the barcode
Rect? boundingBox // bounding box of barcode position in image
List<Offset> corners // list of points representing the corners position of this barcode
```

Here is a list of `BarcodeType` values with its corresponding `Barcode` object. Each Barcode object is a direct subclass of `Barcode`.

<table>
  <tr>
    <th>BarcodeType</th>
    <th>Barcode Object</th>
    <th>Additonal Data</th>
  </tr>
  <tr>
    <td>TEXT</td>
    <td>BarcodeText</td>
    <td><code>displayValue</code></td>
  </tr>
  <tr>
    <td>URL</td>
    <td>BarcodeUrl</td>
    <td><code>title</code> <code>url</code></td>
  </tr>
  <tr>
    <td>EMAIL</td>
    <td>BarcodeEmail</td>
    <td><code>emailType</code> <code>address</code> <code>subject</code> <code>body</code></td>
  </tr>
  <tr>
    <td>PHONE</td>
    <td>BarcodePhone</td>
    <td><code>phoneType</code> <code>number</code></td>
  </tr>
  <tr>
    <td>SMS</td>
    <td>BarcodeSms</td>
    <td><code>number</code> <code>message</code></td>
  </tr>
  <tr>
    <td>WIFI</td>
    <td>BarcodeWifi</td>
    <td><code>wifiType</code> <code>ssid</code> <code>password</code></td>
  </tr>
  <tr>
    <td>CALENDAR_EVENT</td>
    <td>BarcodeCalendarEvent</td>
    <td><code>status</code> <code>summary</code> <code>description</code> <code>location</code> <code>start</code> <code>end</code> <code>organizer</code></td>
  </tr>
  <tr>
    <td>CONTACT_INFO</td>
    <td>BarcodeContactInfo</td>
    <td><code>title</code> <code>name</code> <code>organization</code> <code>emails</code> <code>phones</code> <code>addresses</code> <code>urls</code></td>
  </tr>
  <tr>
    <td>DRIVER_LICENSE</td>
    <td>BarcodeDriverLicense</td>
    <td><code>documentType</code> <code>licenseNumber</code> <code>firstName</code> <code>middleName</code> <code>lastName</code> <code>gender</code> <code>birthDate</code> <code>street</code> <code>city</code> <code>state</code> <code>zip</code> <code>issueDate</code> <code>expiryDate</code> <code>issuingCountry</code></td>
  </tr>
  <tr>
    <td>GEO</td>
    <td>BarcodeGeo</td>
    <td><code>latitude</code> <code>longitude</code></td>
  </tr>
  <tr>
    <td>ISBN</td>
    <td>BarcodeISBN</td>
    <td></td>
  </tr>
  <tr>
    <td>PRODUCT</td>
    <td>BarcodeProduct</td>
    <td></td>
  </tr>
  <tr>
    <td>UNKNOWN</td>
    <td></td>
    <td></td>
  </tr>
<table>

### Dispose

```dart
scanner.dispose();
```

## Example Project

You can learn more from example project [here](example).
