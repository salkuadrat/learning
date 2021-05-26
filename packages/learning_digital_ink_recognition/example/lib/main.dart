import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
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
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => DigitalInkRecognitionState(),
        child: DigitalInkRecognitionPage(),
      ),
    );
  }
}

class DigitalInkRecognitionPage extends StatefulWidget {
  @override
  _DigitalInkRecognitionPageState createState() =>
      _DigitalInkRecognitionPageState();
}

class _DigitalInkRecognitionPageState extends State<DigitalInkRecognitionPage> {
  DigitalInkRecognitionState get state => Provider.of(context, listen: false);
  DigitalInkRecognition _recognition = DigitalInkRecognition();

  Offset? _lastMovePoint;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async => await _reset());
  }

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    await _recognition.start();
  }

  Future<void> _actionDown(Offset point) async {
    print('actionDown (${point.dx}, ${point.dy})');
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    print('actionMove (${point.dx}, ${point.dy})');
    _lastMovePoint = point;
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp(Offset point) async {
    print('actionUp (${point.dx}, ${point.dy})');
    await _recognition.actionUp(point);
  }

  Future<void> _startRecognition() async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.data = await _recognition.process();
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ML Digital Ink Recognition'),
        ),
        body: Center(
          child: GestureDetector(
            onScaleStart: (details) async =>
                await _actionDown(details.localFocalPoint),
            onScaleUpdate: (details) async =>
                await _actionMove(details.localFocalPoint),
            onScaleEnd: (details) async => await _actionUp(_lastMovePoint!),
            child: Container(
              color: Colors.teal[100],
            ),
          ),
        ),
      ),
    );
  }
}

class DigitalInkRecognitionState extends ChangeNotifier {
  List<RecognitionCandidate> _data = [];
  bool _isProcessing = false;

  List<RecognitionCandidate> get data => _data;
  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set data(List<RecognitionCandidate> data) {
    _data = data;
    notifyListeners();
  }

  @override
  String toString() {
    return isNotEmpty ? _data.first.text : '';
  }

  String toCompleteString() {
    return isNotEmpty ? _data.map((c) => c.text).toList().join(', ') : '';
  }
}
