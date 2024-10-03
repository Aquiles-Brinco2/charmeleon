import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:saltarin/game/assets.dart';

class Platform extends SpriteComponent with CollisionCallbacks {
  Platform({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(Assets.platform);

    final hitbox = RectangleHitbox.relative(
      Vector2(1, 1),
      parentSize: size,
    );
    add(hitbox..collisionType = CollisionType.passive);
  }
}
