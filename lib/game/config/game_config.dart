import 'package:flame/components.dart';

class GameConfig {
  // Defines the number of rows in the grid
  static const rows = 12;

  // Defines the number of columns in the grid
  static const columns = 6;

  // Cell size in px
  static const cellSize = 60;

  // Initial snake length
  static const initialSnakeLength = 1;

  // Initial snake's head index
  static final headIndex = Vector2(initialSnakeLength.toDouble(), 20);

  // Initial fps
  static const fps = 3.0;

  // Food radius offset, the empty space in the cell
  static const foodRadius = 5.0;

  // Snake is composed of bunch of squares and this config defines the thickness of the lines
  static const snakeLineThickness = 4.0;
}
