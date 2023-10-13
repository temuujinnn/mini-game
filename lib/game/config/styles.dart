import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Styles {
  static Paint white = BasicPalette.white.paint();
  static Paint blue = BasicPalette.blue.paint();
  static Paint red = BasicPalette.red.paint();
  final img = Image.asset('assets/image.png');

  static Paint snakeBody = BasicPalette.black.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  static Paint gameOver = BasicPalette.red.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
}
