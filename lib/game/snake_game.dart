import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:mini_app/game/component/ai.dart';
import 'package:mini_app/game/component/healthbar.dart';
import 'package:mini_app/game/component/world.dart';

import 'component/background.dart';
import 'config/game_config.dart';
import 'snake/grid.dart';
import 'snake/offsets.dart';

class SnakeGame extends FlameGame with TapDetector {
  Grid grid = Grid(GameConfig.rows, GameConfig.columns, GameConfig.cellSize);
  // ignore: non_constant_identifier_names
  WorldView? world_view;
  OffSets offSets = OffSets(Vector2.zero());
  late final score = 100;
  late final second = 0;
  late final TextComponent scoreText;
  late final TextBoxComponent gamesecond;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    offSets = OffSets(canvasSize);

    add(BackGround('land.png', GameConfig.cellSize));

    // ignore: avoid_function_literals_in_foreach_calls
    grid.cells.forEach((rows) => rows.forEach((cell) => add(cell)));
    grid.generateFood();
    final enemy = EnemyComponent(position: Vector2(100, 160));
    add(enemy);
    world_view = WorldView(grid);
    add(world_view!);
    add(
      scoreText = TextComponent(
        text: 'Your score: ${score.toString()}',
        position: size - Vector2(10, 900),
        anchor: Anchor.topRight,
        priority: 1,
      ),
    );
    add(
      gamesecond = TextBoxComponent(
        text: 'Time: ${second.toString()}',
        position: Vector2(0, 0),
        anchor: Anchor.topLeft,
        priority: 1,
      ),
    );

    // add(ExplosionComponent());
  }

  @override
  void onTapUp(TapUpInfo info) {
    world_view!.onTapUp(info);
  }
}
