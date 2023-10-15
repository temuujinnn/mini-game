import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GerComp extends SpriteAnimationComponent with HasGameRef, TapCallbacks {
  GerComp(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(50),
          priority: 1,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'animations/ger.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        textureSize: Vector2(80, 120),
        stepTime: 0.3,
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
