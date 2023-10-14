import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:meta/meta.dart';

class Ember<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameReference<T> {
  Ember({super.position, Vector2? size, super.priority, super.key})
      : super(
          size: size ?? Vector2.all(100),
          anchor: Anchor.center,
        );

  @mustCallSuper
  @override
  Future<void> onLoad() async {
    try {
      animation = await game.loadSpriteAnimation(
        'animations/wolf.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2.all(48),
          stepTime: 0.15,
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
