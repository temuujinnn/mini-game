import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_app/game/config/game_config.dart';
import 'package:mini_app/game/config/styles.dart';
import 'package:mini_app/game/snake/command_queue.dart';
import 'package:mini_app/game/snake/grid.dart';
import 'package:mini_app/game/snake/snake.dart';
import 'package:mini_app/game/snake_game.dart';

import 'cell.dart';
import 'dynamic_fps_position_component.dart';

class WorldView extends DynamicFpsPositionComponent with HasGameRef<SnakeGame> {
  final Grid _grid;
  final Snake _snake = Snake();
  final CommandQueue _commandQueue = CommandQueue();

  bool gameOver = false;

  WorldView(this._grid) : super(GameConfig.fps) {
    _initializeSnake();
  }

  @override
  void updateDynamic(double dt) {
    if (!gameOver) {
      _commandQueue.evaluateNextInput(_snake);

      var nextCell = _getNextCell();

      if (nextCell != Grid.border) {
        if (_snake.checkCrash(nextCell)) {
          gameOver = true;
        } else {
          if (nextCell.cellType == CellType.food) {
            print('nextCell.cellType ${nextCell.cellType}');
            print('CellType.food ${CellType.food}');
            _snake.grow(nextCell);
            _grid.generateFood();
          } else {
            _snake.move(nextCell);
          }
        }
      } else {
        gameOver = true;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (gameOver) {
      canvas.drawRect(
          Rect.fromLTRB(
              2, 2, gameRef.canvasSize.x - 2, gameRef.canvasSize.y - 2),
          Styles.gameOver);
    }
  }

  void onTapUp(TapUpInfo info) {
    final touchPoint = info.eventPosition.game;
    _commandQueue.add(touchPoint);
  }

  void _initializeSnake() {
    var headIndex = GameConfig.headIndex;
    var snakeLength = GameConfig.initialSnakeLength;

    for (int i = 0; i < snakeLength; i++) {
      var snakePart =
          _grid.findCell(headIndex.x.toInt() - i, headIndex.y.toInt());
      _snake.addCell(snakePart);
      if (i == 0) {
        _snake.setHead(snakePart);
      }
    }
  }

  //TODO use vector addition instead of a switch
  Cell _getNextCell() {
    var row = _snake.head.row;
    var column = _snake.head.column;

    switch (_snake.direction) {
      case Direction.up:
        row--;
        break;
      case Direction.right:
        column++;
        break;
      case Direction.down:
        row++;
        break;
      case Direction.left:
        column--;
        break;
    }
    return _grid.findCell(column, row);
  }
}
