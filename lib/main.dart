import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());


// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: FirstPage(),
//      home: FirstPage(),
    );
  }
// #enddocregion build
}
//
//
class FirstPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () async{
            var client = http.Client();
            try {
              await _request();
            } finally {
              client.close();
            }
          },
          child: Text('http3'),
        ),
      ),
    );
  }


//  curl -X POST -  --data "{\"event_type\":\"test_trigger\",\"client_payload\":{\"test\":true}}"
//
  void _request() async {

    Map<String, String> headers = {
      'Authorization': 'token 2ce2dfca25ccc64703948e677201d08d7413b74a',
    'Content-Type': 'application/json'};
    Map<String, Object> body = {
      'event_type': 'test_trigger', 'client_payload':{'test':true}};
    String url = "https://api.github.com/repos/ishidafuu/dmui/dispatches";
    print(json.encode(body));
    final response = await http.post(url,
        body: json.encode(body),
        headers: headers);

    print(response.statusCode);
    print(response.body);
//    return;
  }

}



class SampleResponse {
//  final number sampleId;
//  final String sampleName;
//
//  SampleResponse({
//    this.sampleId,
//    this.sampleName
//  });
//
//  factory SampleResponse.fromJson(Map<String, dynamic> json) {
//    return Spot(
//      sampleId: json['sampleId'],
//      sampleName: json['sampleName'],
//    );
//  }
}


class SecondPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context, 'backback');
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}

// #docregion RWS-var
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
// #enddocregion RWS-build
// #docregion RWS-var
}
// #enddocregion RWS-var

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}