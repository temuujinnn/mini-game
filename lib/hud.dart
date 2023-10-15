import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/wolf_game.dart';

class Hud extends PositionComponent with HasGameRef<WolfGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 0,
  });

  late TextComponent _scoreTextComponent;
  late RectangleComponent healthBarBackground, healthBar;

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: 'X ${game.score}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(60, 60),
    );
    game.camera.viewport.add(_scoreTextComponent);

    final scoreImage = await game.loadSprite('score.png');
    final healthImage = await game.loadSprite('health.png');
    game.camera.viewport.add(
      SpriteComponent(
        sprite: scoreImage,
        position: Vector2(20, 60),
        size: Vector2.all(32),
        anchor: Anchor.center,
      ),
    );

    game.camera.viewport.add(
      SpriteComponent(
        sprite: healthImage,
        position: Vector2(20, 20),
        size: Vector2.all(32),
        anchor: Anchor.center,
      ),
    );

    healthBarBackground = RectangleComponent(
      size:

          /// world half size
          Vector2(200, 20),
      position: Vector2(40, 10),
      paint: BasicPalette.white.paint(),
    );

    healthBar = RectangleComponent(
      size:

          /// world half size
          Vector2(200, 20),
      position: Vector2(40, 10),
      paint: BasicPalette.red.paint(),
    );
    game.camera.viewport.add(healthBarBackground);
    game.camera.viewport.add(healthBar);
  }

  @override
  void update(double dt) {
    if (game.isPlaying) {
      _scoreTextComponent.text = ' X${game.score}';
      healthBar.width = game.health;
    }
    super.update(dt);
  }
}
