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
  String _theWordState = ""; //Word
  int _theScore = 0; //Score
  int _actualWordType = 0; //Noun or adjective
  bool _enable = true;
  Color _wordcolor = Colors.lightBlue;
  Color _buttonColor = Colors.lightBlue;
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
      setState(() {
        randomItem = (nouns.toList()..shuffle()).first;
      });
    } else {
      logInfo("change to adjective");
      setState(() {
        randomItem = (adjectives.toList()..shuffle()).first;
      });
      _actualWordType = 1;
    }
    _theWordState = randomItem;
    setState(() {
      _enable = true;
      _buttonColor = Colors.lightBlue;
    });
  }

  void _onPressed(String type) {
    setState(() {
      _buttonColor = Colors.blueGrey;
      _enable = true;
    });
    if (type == 'Noun') {
      isNoun();
    } else {
      isAdjective();
    }
  }

  void isNoun() {
    _actualWordType == 0 ? increaseScore() : reduceScore();
  }

  void isAdjective() {
    _actualWordType == 1 ? increaseScore() : reduceScore();
  }

  void increaseScore() {
    setState(() {
      _theScore = _theScore + 1;
    });
    setRandomWord();
  }

  void reduceScore() {
    setState(() {
      _wordcolor = Colors.red;
      if (_theScore <= 0) {
        _theScore = 0;
      } else {
        _theScore = _theScore - 1;
      }
      Timer(const Duration(seconds: 1), () {
        setRandomWord();
        setState(() {
          _wordcolor = Colors.lightBlue;
        });
      });
    });
  }

  void _onReset() {
    setState(() {
      _theScore = 0;
    });
    setRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(flex: 1),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              child: Text(
                "Score: ${_theScore.toString()}",
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                _theWordState,
                style: TextStyle(
                    fontSize: 60,
                    color: _wordcolor,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                optionButtom("noun", "Noun", _buttonColor, _enable),
                optionButtom("adjec", "Adjective", _buttonColor, _enable),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () => _onReset(),
                icon: const Icon(Icons.restart_alt_rounded),
                iconSize: 60,
                color: Colors.lightBlue,
              ))
        ],
      ),
    );
  }

  Widget optionButtom(String _name, String _value, Color _color, bool _is) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: () => _is ? _onPressed(_value) : "",
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(20, 200),
            primary: _color,
          ),
          child: Text(_name,
              style: const TextStyle(
                fontSize: 40,
              ))),
    ));
  }
}
