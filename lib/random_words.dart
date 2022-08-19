import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  final _random = Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      logInfo("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      logInfo("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }
  }

  void _onPressed() {}

  void _onReset() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(_theState),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => _onPressed(), child: const Text("Noun")),
              ElevatedButton(
                  onPressed: () => _onPressed(), child: const Text("Adjective"))
            ],
          ),
          ElevatedButton(
              onPressed: () => _onReset(), child: const Text("Reset")),
        ],
      ),
    );
  }
}
