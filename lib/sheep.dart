import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Sheep extends SpriteComponent with HasGameRef, TapCallbacks {
  Sheep(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(50),
          priority: 1,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('nine-box.png');
    // animation = await game.loadSpriteAnimation(
    //   'animations/sheep.png',
    //   SpriteAnimationData.sequenced(
    //     amount: 3,
    //     textureSize: Vector2(47, 51),
    //     stepTime: 0.15,
    //   ),
    // );
    paint = Paint()..color = Colors.white;
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
