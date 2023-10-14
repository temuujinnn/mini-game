import 'dart:math';

import 'package:flame/components.dart';
import 'package:mini_app/game/component/ai.dart';

class Malchin extends TimerComponent with HasGameRef {
  final Random random = Random();
  final _halfWidth = EnemyComponent.initialSize.x / 2;

  Malchin() : super(period: 0.05, repeat: true);

  @override
  void onTick() {
    game.addAll(
      List.generate(
        5,
        (index) => EnemyComponent(
          position: Vector2(
            60 + (game.size.x - _halfWidth) * random.nextDouble(),
            0,
          ),
        ),
      ),
    );
  }
}
