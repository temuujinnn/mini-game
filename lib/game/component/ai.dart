import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mini_app/game/config/game_config.dart';
import 'package:mini_app/game/snake_game.dart';

class EnemyComponent extends SpriteAnimationComponent
    with HasGameReference<SnakeGame>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(60);

  EnemyComponent({required super.position})
      : super(size: initialSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'wolf.png',
      SpriteAnimationData.sequenced(
        stepTime: 1,
        amount: 1,
        textureSize: Vector2.all(GameConfig.rows.toDouble()),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    x += speed * dt;
    if (y >= game.size.x) {
      removeFromParent();
    }
    // super.update(dt);
    // x += speed * dt;
    // if (x >= game.size.x) {
    //   removeFromParent();
    // }
  }

  void takeHit() {
    removeFromParent();

    // game.add(ExplosionComponent(position: position));
    // game.increaseScore();
  }
}
