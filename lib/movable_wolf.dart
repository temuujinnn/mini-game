import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_app/game_map.dart';
import 'package:mini_app/sheep.dart';
import 'bullet.dart';
import 'commons/ember.dart';

import 'malchin.dart';
import 'shake_effect.dart';
import 'wolf_game.dart';

enum PlayerState { crashed, jumping, running, waiting }

class MovableWolf extends Ember<WolfGame>
    with CollisionCallbacks, KeyboardHandler {
  final JoystickComponent joystick;

  MovableWolf(this.joystick)
      : super(
          size: Vector2.all(100.0),
        );

  static const double speed = 300;
  static final TextPaint textRenderer = TextPaint(
    // ignore: prefer_const_constructors
    style: TextStyle(
        color: Colors.red,
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 4.0,
        shadows: const [
          Shadow(
            blurRadius: 2,
            color: Colors.black,
            offset: Offset(2, 2),
          ),
        ]),
  );
  final Vector2 velocity = Vector2.zero();

  late final maxPosition = Vector2.all(GameMap.size - size.x / 2);
  late final minPosition = -maxPosition;
  late PlayerState current;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(CircleHitbox());
    current = PlayerState.waiting;
  }

  void jump(double speed) {
    if (current == PlayerState.jumping) {
      return;
    }

    current = PlayerState.jumping;
    // _jumpVelocity = initialJumpVelocity - (speed / 500);
  }

  void reset() {
    // y = groundYPos;
    // _jumpVelocity = 0.0;
    current = PlayerState.running;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()

        /// when doggie hit something then it's not moving
        // &&
        // activeCollisions.isEmpty
        ) {
      position.add(joystick.relativeDelta * speed * dt);
      // angle = joystick.delta.screenAngle();
    }
    final deltaPosition = velocity * (speed * dt);
    game.timePlaying += deltaPosition.length;
    position.add(deltaPosition);
    position.clamp(minPosition, maxPosition);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Sheep) {
      await other.add(
        ScaleEffect.to(
          Vector2.all(1.5),
          EffectController(
            duration: 0.2,
            alternate: true,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        ),
      );

      game.score = game.score + 1;
      game.health = 200;
      game.world.addAll([
        Sheep(GameMap.generateCoordinates()),
        Sheep(GameMap.generateCoordinates()),
      ]);
      game.world.addAll([
        Malchin(GameMap.generateCoordinates()),
      ]);

      for (var i = 0; i < game.malchin.length; i++) {
        print('game.malchin.length');
        print(game.malchin.length);
        game.malchin[i].shoot();
      }

      other.add(TextComponent(
        text: '100',
        textRenderer: textRenderer,
        position: (other.size / 2)..y = other.size.y / 2,
        anchor: Anchor.center,
      ));
      await Future.delayed(const Duration(milliseconds: 250));
      other.add(RemoveEffect());
    }
    if (other is Malchin) {
      game.health = game.health - 30;
      game.camera.viewfinder.add(
        MoveEffect.by(
          Vector2(25, 25),
          PerlinNoiseEffectController(duration: 0.3, frequency: 500),
        ),
      );
      // make it white and red
    }
    if (other is Ball) {
      game.health = game.health - 10;
      game.camera.viewfinder.add(
        MoveEffect.by(
          Vector2(30, 30),
          PerlinNoiseEffectController(duration: 0.3, frequency: 500),
        ),
      );
      other.add(RemoveEffect());
      // make it white and red
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;

    final bool handled;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;
      handled = true;
    } else {
      handled = false;
    }

    if (handled) {
      // angle = -velocity.angleToSigned(Vector2(1, 0));
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }
}
