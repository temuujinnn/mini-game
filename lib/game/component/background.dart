import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:mini_app/game/snake_game.dart';

class BackGround extends PositionComponent with HasGameRef<SnakeGame> {
  Offset start = Offset.zero;
  Offset end = Offset.zero;
  final String imagePath;
  final int cellSize;
  BackGround(this.imagePath, this.cellSize);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    start = gameRef.offSets.start.toOffset();
    end = gameRef.offSets.end.toOffset();
    final image = await gameRef.images.load(imagePath);
    size.setValues(image.width.toDouble(), image.height.toDouble());
  }

  @override
  void render(Canvas canvas) {
    for (double x = start.dx; x < end.dx; x += cellSize) {
      for (double y = start.dy; y < end.dy; y += cellSize) {
        final image = gameRef.images.fromCache(imagePath);

        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          Rect.fromLTWH(x, y, size.x, size.y),
          Paint(),
        );
      }
    }
  }
}
