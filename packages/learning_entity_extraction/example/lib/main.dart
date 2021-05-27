import 'package:flutter/material.dart';
import 'package:learning_entity_extraction/learning_entity_extraction.dart';
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
        create: (_) => EntityExtractionState(),
        child: EntityExtractionPage(),
      ),
    );
  }
}

class EntityExtractionPage extends StatefulWidget {
  @override
  _EntityExtractionPageState createState() => _EntityExtractionPageState();
}

class _EntityExtractionPageState extends State<EntityExtractionPage> {
  TextEditingController _controller = TextEditingController();
  EntityExtractor _extractor = EntityExtractor();

  EntityExtractionState get state => Provider.of(context, listen: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      //await testModelManager();
      //await testExtraction();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _extractor.dispose();
    super.dispose();
  }

  /* Future<void> testExtraction() async {
    String text =
        'Meet me at 1600 Amphitheatre Parkway, Mountain View, CA, 94043 Let’s organize a meeting to discuss.';
    List result = await _extractor.extract(text);
    print(result);
  } */

  /* Future<void> testModelManager() async {
    var models = await EntityModelManager.list();
    print(models);
    var downloaded = await EntityModelManager.download(ENGLISH);
    print('Donwloaded: $downloaded');
    var exist = await EntityModelManager.exist(ENGLISH);
    print('HasModel: $exist');
    models = await EntityModelManager.list();
    print(models);
    var deleted = await EntityModelManager.delete(ENGLISH);
    print('Deleted: $deleted');
    models = await EntityModelManager.list();
    print(models);
  } */

  Future<void> _extract() async {
    state.startProcessing();
    List extractedItems = await _extractor.extract(_controller.text);
    state.data =
        extractedItems.map((item) => item.toString()).toList().join('\n\n');
    state.stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Entity Extraction'),
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
                text: 'Extract Entity',
                onPressed: _extract,
              ),
              SizedBox(height: 25),
              Consumer<EntityExtractionState>(
                builder: (_, state, __) => Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      state.data,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EntityExtractionState extends ChangeNotifier {
  String _data = '';
  bool _isProcessing = false;

  String get data => _data;
  bool get isProcessing => _isProcessing;

  void startProcessing() {
    _data = 'Extracting...';
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
