import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_translate/learning_translate.dart';

class LearningTranslate extends StatefulWidget {
  @override
  _LearningTranslateState createState() => _LearningTranslateState();
}

class _LearningTranslateState extends State<LearningTranslate> {
  TextEditingController _controller = TextEditingController();
  Translator _translator = Translator(from: FRENCH, to: ENGLISH);

  LearningTranslateState get state => Provider.of(context, listen: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await TranslationModelManager.download(FRENCH);
    });
  }

  @override
  void dispose() {
    _translator.dispose();
    super.dispose();
  }

  Future<void> _startTranslating() async {
    bool exist = await TranslationModelManager.check(FRENCH);

    if (!exist) {
      state.startDownloading();
      await TranslationModelManager.download(FRENCH);
      state.stopDownloading();
    }

    state.startProcessing();
    state.data = await _translator.translate(_controller.text);
    state.stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On-Device Translation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextField(
              autofocus: true,
              controller: _controller,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
              ),
              minLines: 5,
              maxLines: 10,
              style: TextStyle(fontSize: 18, color: Colors.blueGrey[700]),
              onChanged: (_) => state.clear(),
            ),
            SizedBox(height: 15),
            NormalBlueButton(
              text: 'Translate from FR to EN',
              onPressed: _startTranslating,
            ),
            SizedBox(height: 25),
            Consumer<LearningTranslateState>(
              builder: (_, state, __) => Center(
                child: Text(
                  state.data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LearningTranslateState extends ChangeNotifier {
  String _data = '';
  bool _isProcessing = false;
  bool _isDownloading = false;

  String get data => _data;
  bool get isProcessing => _isProcessing;
  bool get isDownloading => _isDownloading;

  void startProcessing() {
    _data = 'Translating...';
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  void startDownloading() {
    _data = 'Downloading translation model...';
    _isDownloading = true;
    notifyListeners();
  }

  void stopDownloading() {
    _isDownloading = false;
    notifyListeners();
  }

  set data(String data) {
    _data = data;
    notifyListeners();
  }

  void clear() {
    _data = '';
    notifyListeners();
  }
}
