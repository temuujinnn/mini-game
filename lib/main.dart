import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/game/snake_game.dart';
// import 'package:mini_app/home/home_page.dart';

void main() {
  runApp(
    // HomePage();
    GameWidget(
      game: SnakeGame(),
    ),
  );
}
