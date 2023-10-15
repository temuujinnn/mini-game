import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:mini_app/game_map.dart';
import 'package:mini_app/movable_wolf.dart';
import 'package:mini_app/sheep.dart';

import 'dead_menu.dart';

enum GameState { playing, intro, gameOver }

class WolfGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  static const String description = '''
    Move around with W, A, S, D and notice how the camera follows the ember 
    sprite.\n
    If you collide with the gray squares, the camera reference is changed from
    center to topCenter.\n
    The gray squares can also be clicked to show how the coordinate system
    respects the camera transformation.
  ''';

  WolfGame({required this.viewportResolution})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: viewportResolution.x / 2,
            height: viewportResolution.y / 2,
          ),
        );

  // late final Image spriteImage;

  late MovableWolf player;
  final Vector2 viewportResolution;
  late JoystickComponent joystick;

  late final TextComponent scoreText;
  // late final TextComponent healthText;

  int _health = 100;
  int get health => _health;
  set health(int newHealth) {
    _health = newHealth;
    // healthText.text = 'HEALTH: ${scoreString(_health)}';
  }

  int _score = 0;
  int get score => _score;
  set score(int newScore) {
    _score = newScore;
    scoreText.text = 'SCORE: ${scoreString(_score)}';
  }

  String scoreString(int score) => score.toString().padLeft(5, '0');

  /// Used for score calculation
  double _distanceTraveled = 0;

  @override
  Future<void> onLoad() async {
    /// Joystick
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    scoreText = TextComponent(
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 30,
          fontFamily: 'PressStart2P',
        ),
      ),
    );
    scoreText.text = 'SCORE: 00000';

    add(scoreText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      return;
    }

    if (isPlaying) {
      // health = health - 1;
      timePlaying += dt;
      _distanceTraveled += dt * currentSpeed;
      // score = _distanceTraveled ~/ 50;

      if (currentSpeed < maxSpeed) {
        currentSpeed += acceleration * dt;
      }
      if (health <= 0) {
        gameOver();
      }
    }
  }

  GameState state = GameState.intro;
  double currentSpeed = 0.0;
  double timePlaying = 0.0;

  final double acceleration = 10;
  final double maxSpeed = 2500.0;
  final double startSpeed = 600;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  @override
  void onTapDown(TapDownInfo info) {
    onAction();
  }

  void onAction() {
    if (isGameOver || isIntro) {
      restart();
      return;
    }
    player.jump(currentSpeed);
  }

  void gameOver() {
    print('game over');
    state = GameState.gameOver;

    player.current = PlayerState.crashed;
    currentSpeed = 0.0;
  }

  void restart() {
    world.add(GameMap());
    world.addAll(
      List.generate(30, (_) => Sheep(GameMap.generateCoordinates())),
    );
    world.add(player = MovableWolf(joystick));
    camera.follow(player, maxSpeed: 300);
    camera.setBounds(GameMap.bounds);
    camera.viewport.add(scoreText);
    camera.viewport.add(joystick);
    state = GameState.playing;
    player.reset();
    currentSpeed = startSpeed;
    timePlaying = 0.0;
    score = 0;
    _distanceTraveled = 0;
  }
}
