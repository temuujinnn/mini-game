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
    animation = await game.loadSpriteAnimation(
      random == 1 ? 'animations/sheep2.png' : 'animations/sheep1.png',
      SpriteAnimationData.sequenced(
        amount: 3 + random,
        textureSize: Vector2(49, 50),
        stepTime: 0.15,
      ),
    );
    paint = Paint()..color = Colors.black;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    /// add random movement to sheep  based on 4 directions every 200 ms

    int random = Random().nextInt(4);
    if (dt % 5 == 0) {
      if (random == 0) {
        position.x += 4;
      } else if (random == 1) {
        position.x -= 4;
      } else if (random == 2) {
        position.y += 4;
      } else if (random == 3) {
        position.y -= 4;
      }
    } else {
      if (random == 0) {
        position.x += 1;
      } else if (random == 1) {
        position.x -= 1;
      } else if (random == 2) {
        position.y += 1;
      } else if (random == 3) {
        position.y -= 1;
      }
    }
    // if (position.x < 1000 &&
    //     position.y < 1000 &&
    //     position.x > -1000 &&
    //     position.y > -1000) {
    //   if (random == 0) {
    //     position.x += 2;
    //   } else if (random == 1) {
    //     position.x -= 2;
    //   } else if (random == 2) {
    //     position.y += 2;
    //   } else if (random == 3) {
    //     position.y -= 2;
    //   }
    // }
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
