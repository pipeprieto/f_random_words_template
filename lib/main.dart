import 'package:f_template_juego_taller1/random_words.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RandomWords",
      home: RandomWords()));
}
