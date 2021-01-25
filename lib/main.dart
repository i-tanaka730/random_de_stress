import 'package:flutter/material.dart';
import 'micro_cms.dart';
import 'de_stress_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(RandomDeStressApp());
}

class RandomDeStressApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random DeStress',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RandomDeStressPage(),
    );
  }
}

class RandomDeStressPage extends StatefulWidget {
  @override
  _RandomDeStressPageState createState() => _RandomDeStressPageState();
}

class _RandomDeStressPageState extends State<RandomDeStressPage> {

  // ignore: non_constant_identifier_names
  DeStressResult _CurrentDeStress;
  MicroCmsService _microCmsService = new MicroCmsService();
  DeStressParser _deStressParser = new DeStressParser();

  void _init() async {
    await _parse();
    _update();
  }

  Future _parse() async {
    var url = DotEnv().env['MICRO_CMS_URL'];
    var apiKey = DotEnv().env['MICRO_CMS_API_KEY'];
    var deStressJson = await _microCmsService.getDeStressJson(url, apiKey);
    _deStressParser.parse(deStressJson);
  }

  void _update() {
    setState(() {
      _CurrentDeStress = _deStressParser.getDeStressAtRandom();
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_CurrentDeStress != null ? _CurrentDeStress.title : ""),
      ),
      body: _CurrentDeStress != null ?
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Image.network(_CurrentDeStress.imageUrl, width: 300, height: 300),
                Text(_CurrentDeStress.description, style: TextStyle(fontSize: 18),),
              ],
            ),
          )
        ],
      ) :
      Center(child: CircularProgressIndicator()) ,

      floatingActionButton: FloatingActionButton(
        onPressed: _update,
        child: Icon(Icons.update),
      ));
  }
}
