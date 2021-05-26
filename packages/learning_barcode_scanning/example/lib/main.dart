import 'package:flutter/material.dart';
import 'package:learning_barcode_scanning/learning_barcode_scanning.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: ChangeNotifierProvider(
        create: (_) => BarcodeScanningState(),
        child: BarcodeScanningPage(),
      ),
    );
  }
}

class BarcodeScanningPage extends StatefulWidget {
  @override
  _BarcodeScanningPageState createState() => _BarcodeScanningPageState();
}

class _BarcodeScanningPageState extends State<BarcodeScanningPage> {
  BarcodeScanningState get state => Provider.of(context, listen: false);

  BarcodeScanner _scanner = BarcodeScanner(formats: [
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

  @override
  void dispose() {
    _scanner.dispose();
    super.dispose();
  }

  Future<void> _scan(InputImage image) async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = image;
      state.data = await _scanner.scan(image);
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputCameraView(
      mode: InputCameraMode.gallery,
      cameraDefault: InputCameraType.rear,
      title: 'Barcode Scanning',
      onImage: _scan,
      overlay: Consumer<BarcodeScanningState>(
        builder: (_, state, __) {
          if (state.isEmpty) {
            return Container();
          }

          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Text(
                state.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BarcodeScanningState extends ChangeNotifier {
  InputImage? _image;
  List _data = [];
  bool _isProcessing = false;

  InputImage? get image => _image;
  List get data => _data;

  String? get type => _image?.type;
  InputImageRotation? get rotation => _image?.metadata?.rotation;
  Size? get size => _image?.metadata?.size;

  bool get isProcessing => _isProcessing;
  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => _data.isEmpty;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set isProcessing(bool isProcessing) {
    _isProcessing = isProcessing;
    notifyListeners();
  }

  set image(InputImage? image) {
    _image = image;
    notifyListeners();
  }

  set data(List data) {
    _data = data;
    notifyListeners();
  }

  @override
  String toString() {
    if (_data.first is Barcode) {
      return _data.first.value;
    }

    return '';
  }
}
