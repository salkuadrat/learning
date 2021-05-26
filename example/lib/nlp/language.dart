import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_language/learning_language.dart';

class LearningLanguage extends StatefulWidget {
  @override
  _LearningLanguageState createState() => _LearningLanguageState();
}

class _LearningLanguageState extends State<LearningLanguage> {
  LearningLanguageState get state =>
      Provider.of<LearningLanguageState>(context, listen: false);

  TextEditingController _controller = TextEditingController();
  LanguageIdentifier _identifier = LanguageIdentifier();

  @override
  void dispose() {
    _identifier.dispose();
    super.dispose();
  }

  Future<void> _startIdentifying() async {
    state.startProcessing();

    String language = await _identifier.identify(_controller.text);
    state.data = language == 'und' ? 'Not Identified' : language.toUpperCase();
    state.stopProcessing();
  }

  Future<void> _startIdentifyingPossibleLanguages() async {
    state.startProcessing();

    List<IdentifiedLanguage> languages =
        await _identifier.idenfityPossibleLanguages(_controller.text);

    String result = '';
    for (IdentifiedLanguage l in languages) {
      result += '${l.language.toUpperCase()} (${l.confidence.toString()})\n';
    }

    state.data = result;
    state.stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Identification'),
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
              text: 'Identify Language',
              onPressed: _startIdentifying,
            ),
            SizedBox(height: 8),
            NormalBlueButton(
              text: 'Idenfity Possible Languages',
              onPressed: _startIdentifyingPossibleLanguages,
            ),
            SizedBox(height: 25),
            Consumer<LearningLanguageState>(
              builder: (_, state, __) => Center(
                child: Text(
                  state.isProcessing ? 'Identifying language...' : state.data,
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

class LearningLanguageState extends ChangeNotifier {
  String _data = '';
  bool _isProcessing = false;

  String get data => _data;
  bool get isProcessing => _isProcessing;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
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
