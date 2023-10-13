import 'package:flame/game.dart';
import 'package:flame/input.dart';
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

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    offSets = OffSets(canvasSize);

    add(BackGround('land.png', GameConfig.cellSize));

    // ignore: avoid_function_literals_in_foreach_calls
    grid.cells.forEach((rows) => rows.forEach((cell) => add(cell)));
    grid.generateFood();

    world_view = WorldView(grid);
    add(world_view!);
  }

  @override
  void onTapUp(TapUpInfo info) {
    world_view!.onTapUp(info);
  }
}
