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

  double get _width => MediaQuery.of(context).size.width;
  double _height = 480;

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  // need to call start() at the first time before painting the ink
  Future<void> _init() async {
    //print('Writing Area: ($_width, $_height)');
    await _recognition.start(writingArea: Size(_width, _height));
  }

  // reset the ink recognition
  Future<void> _reset() async {
    state.reset();
    await _recognition.start(writingArea: Size(_width, _height));
  }

  Future<void> _actionDown(Offset point) async {
    state.startWriting(point);
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    state.writePoint(point);
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp() async {
    Offset? point = state.lastPoint;
    state.stopWriting();

    if (point != null) {
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
              Builder(
                builder: (buildContext) {
                  _init();

                  return GestureDetector(
                    onScaleStart: (details) async =>
                        await _actionDown(details.localFocalPoint),
                    onScaleUpdate: (details) async =>
                        await _actionMove(details.localFocalPoint),
                    onScaleEnd: (details) async => await _actionUp(),
                    child: Consumer<DigitalInkRecognitionState>(
                      builder: (_, state, __) => CustomPaint(
                        painter: DigitalInkPainter(writings: state.writings),
                        child: Container(
                          width: _width,
                          height: _height,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              NormalPinkButton(
                text: 'Start Recognition',
                onPressed: _startRecognition,
              ),
              SizedBox(height: 10),
              NormalBlueButton(
                text: 'Reset Canvas',
                onPressed: _reset,
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
