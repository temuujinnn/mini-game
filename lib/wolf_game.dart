import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:mini_app/game_map.dart';
import 'package:mini_app/hud.dart';
import 'package:mini_app/movable_wolf.dart';
import 'package:mini_app/sheep.dart';

import 'Auth/repository.dart';
import 'malchin.dart';

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

  double _health = 100;
  List<Sheep> sheep = [];
  List<Malchin> malchin = [];
  double get health => _health;
  set health(double newHealth) {
    _health = newHealth;
    // healthBar.width = _health * 2;
  }

  int _score = 0;
  int get score => _score;
  set score(int newScore) {
    _score = newScore;
  }

  String scoreString(int score) => score.toString().padLeft(5, '0');

  /// Used for score calculation
  double _distanceTraveled = 0;

  @override
  Future<void> onLoad() async {
    /// Joystick
    final knobPaint = BasicPalette.white.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 50, bottom: 40, right: 40),
      position:

          /// bottom center of the screen
          viewportResolution / 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      return;
    }

    if (isPlaying) {
      health = health - 0.1;
      // healthBar.width = health * 2;
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
    overlays.add('GameOver');
  }

  void restart() async {
    await chargeGame('99110041');
    world.add(GameMap());
    sheep = List.generate(30, (_) => Sheep(GameMap.generateCoordinates()));
    malchin = List.generate(30, (_) => Malchin(GameMap.generateCoordinates()));
    world.addAll(sheep);
    world.addAll(malchin);
    world.add(player = MovableWolf(joystick));
    camera.follow(player, maxSpeed: 300);
    camera.setBounds(GameMap.bounds);
    camera.viewport.add(joystick);
    state = GameState.playing;
    player.reset();
    health = 200;
    add(Hud());
    currentSpeed = startSpeed;
    timePlaying = 0.0;
    score = 0;
    _distanceTraveled = 0;
  }
}
