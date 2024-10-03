import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:saltarin/game/assets.dart';
import 'platform.dart';

class Cloud extends Platform {
  bool isDestroyed = false;

  Cloud({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (!isDestroyed) {
      isDestroyed = true;
      removeFromParent();
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(Assets.cloud);

    final hitbox = RectangleHitbox.relative(
      Vector2(1, 1),
      parentSize: size,
    );
    add(hitbox..collisionType = CollisionType.passive);
  }
}
