import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:mini_app/game_map.dart';
import 'package:mini_app/movable_wolf.dart';
import 'package:mini_app/sheep.dart';
import './commons/ember.dart';

import 'game_panel.dart';

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
            width: viewportResolution.x,
            height: viewportResolution.y,
          ),
        );

  // late final Image spriteImage;

  late MovableEmber ember;
  final Vector2 viewportResolution;
  late JoystickComponent joystick;

  late final Image spriteImage;

  late final gameOverPanel = GameOverPanel();
  late final TextComponent scoreText;

  int _score = 0;
  int _highscore = 0;
  int get score => _score;
  set score(int newScore) {
    _score = newScore;
    scoreText.text = '${scoreString(_score)}  HI ${scoreString(_highscore)}';
  }

  String scoreString(int score) => score.toString().padLeft(5, '0');

  /// Used for score calculation
  double _distanceTraveled = 0;

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('wolf.png');
    const chars = '0123456789HI ';
    final renderer = SpriteFontRenderer.fromFont(
      SpriteFont(
        source: spriteImage,
        size: 23,
        ascent: 23,
        glyphs: [
          for (var i = 0; i < chars.length; i++)
            Glyph(chars[i], left: 954.0 + 20 * i, top: 0, width: 20),
        ],
      ),
      letterSpacing: 2,
    );
    add(
      scoreText = TextComponent(
        position: Vector2(20, 20),
        textRenderer: renderer,
      ),
    );
    score = 0;
    world.add(GameMap());
    add(gameOverPanel);

    /// Joystick
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    world.add(ember = MovableEmber(joystick));
    camera.setBounds(GameMap.bounds);
    camera.follow(ember, maxSpeed: 250);

    world.addAll(
      List.generate(30, (_) => Sheep(GameMap.generateCoordinates())),
    );
    camera.viewport.add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      return;
    }

    if (isPlaying) {
      timePlaying += dt;
      _distanceTraveled += dt * currentSpeed;
      score = _distanceTraveled ~/ 50;

      if (currentSpeed < maxSpeed) {
        currentSpeed += acceleration * dt;
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
    // player.jump(currentSpeed);
  }

  void gameOver() {
    gameOverPanel.visible = true;
    state = GameState.gameOver;
    // player.current = PlayerState.crashed;
    currentSpeed = 0.0;
  }

  void restart() {
    state = GameState.playing;
    // player.reset();
    // horizon.reset();
    currentSpeed = startSpeed;
    gameOverPanel.visible = false;
    timePlaying = 0.0;
    if (score > _highscore) {
      _highscore = score;
    }
    score = 0;
    _distanceTraveled = 0;
  }
}
