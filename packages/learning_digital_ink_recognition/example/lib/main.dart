import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';

import 'painter.dart';

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

  double _height = 480;

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  Future<void> _reset(BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    //print('WritingArea: ($width, $_height)');
    state.reset();
    await _recognition.start(writingArea: Size(width, _height));
  }

  Future<void> _actionDown(Offset point) async {
    //print('actionDown (${point.dx}, ${point.dy})');
    state.startWriting(point);
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    //print('actionMove (${point.dx}, ${point.dy})');
    state.writePoint(point);
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp() async {
    Offset? point = state.lastPoint;
    state.stopWriting();

    if (point != null) {
      //print('actionUp (${point.dx}, ${point.dy})');
      await _recognition.actionUp(point);
    }
  }

  Future<void> _startRecognition() async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.data = await _recognition.process();
      print(state.toCompleteString());
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    _reset(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ML Digital Ink Recognition'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onScaleStart: (details) async =>
                    await _actionDown(details.localFocalPoint),
                onScaleUpdate: (details) async =>
                    await _actionMove(details.localFocalPoint),
                onScaleEnd: (details) async => await _actionUp(),
                child: Consumer<DigitalInkRecognitionState>(
                  builder: (_, state, __) => CustomPaint(
                    painter: DigitalInkPainter(writings: state.writings),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: _height,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              NormalPinkButton(
                text: 'Start Recognition',
                onPressed: _startRecognition,
              ),
              SizedBox(height: 10),
              NormalBlueButton(
                text: 'Reset Canvas',
                onPressed: () => _reset(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DigitalInkRecognitionState extends ChangeNotifier {
  List<List<Offset>> _writings = [];
  List<RecognitionCandidate> _data = [];
  bool _isProcessing = false;

  List<List<Offset>> get writings => _writings;
  List<RecognitionCandidate> get data => _data;
  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;

  Offset? get lastPoint => _writings.last.last;

  List<Offset> _writing = [];

  void reset() {
    _writings = [];
    notifyListeners();
  }

  void startWriting(Offset point) {
    _writing = [point];
    _writings.add(_writing);
    notifyListeners();
  }

  void writePoint(Offset point) {
    if (_writings.isNotEmpty) {
      _writings[_writings.length - 1].add(point);
      notifyListeners();
    }
  }

  void stopWriting() {
    _writing = [];
    notifyListeners();
  }

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
