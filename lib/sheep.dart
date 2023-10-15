import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Sheep extends SpriteAnimationComponent with HasGameRef, TapCallbacks {
  Sheep(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(50),
          priority: 1,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final random = Random().nextInt(2);

    print(random);

    animation = await game.loadSpriteAnimation(
      random == 1 ? 'animations/sheep2.png' : 'animations/sheep1.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2(49, 50),
        stepTime: 0.15,
      ),
    );
    paint = Paint()..color = Colors.black;
    add(RectangleHitbox());
  }

  @override
  void onTapDown(_) {
    add(
      ScaleEffect.to(
        Vector2.all(scale.x >= 2.0 ? 1 : 2),
        EffectController(duration: 0.3),
      ),
    );
  }
}
