import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class LoseZone extends PositionComponent with CollisionCallbacks {
  LoseZone({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;

    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}
