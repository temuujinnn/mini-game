import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Malchin extends SpriteAnimationComponent with HasGameRef, TapCallbacks {
  Malchin(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(50),
          priority: 1,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final random = Random().nextInt(2);
    animation = await game.loadSpriteAnimation(
      random == 1 ? 'animations/malchin2.png' : 'animations/malchin.png',
      SpriteAnimationData.sequenced(
        amount: 3 + random,
        textureSize: Vector2(42, 48),
        stepTime: 0.15,
      ),
    );
    paint = Paint()..color = Colors.black;
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  shoot() {}
}
