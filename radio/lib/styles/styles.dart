import 'package:flutter/material.dart';

class Styles {
  static const TextStyle appTittle = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appTittlePink = TextStyle(
    fontSize: 24,
    color: selectedColor,
    fontWeight: FontWeight.bold,
  );

  static const Color bkgColor = Color.fromARGB(255, 1, 1, 42);
  static const Color selectedColor = Color.fromARGB(255, 255, 41, 109);
  static const Color notSelectedColor = Colors.blueGrey;
  static const List<Color> musicColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.yellowAccent
  ];

  static const TextStyle radioCode =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle radioCodeNotSelected = TextStyle(
      fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold);

  static const TextStyle radioName =
      TextStyle(fontSize: 18, color: Colors.white);

  static const TextStyle radioNameNotSelected =
      TextStyle(fontSize: 18, color: Colors.blueGrey);

  static const TextStyle tabs =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle radioCodePlayer =
      TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle radioPlayerTitle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
}
