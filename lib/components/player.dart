import 'package:flutter/gestures.dart';
import 'package:saltarin/components/lose_zone.dart';
import 'package:saltarin/components/platform.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:saltarin/game/Saltarin.dart';
import 'package:saltarin/game/assets.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<Saltarin> {
  Vector2 velocity = Vector2(0, 0);
  double gravity = 1100;
  double jumpSpeed = -600;

  Player({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(Assets.player);

    final hitbox = RectangleHitbox.relative(
      Vector2(0.8, 0.8),
      parentSize: size,
    );
    add(hitbox..collisionType = CollisionType.active);

    gyroscopeEventStream().listen((GyroscopeEvent event) {
      velocity.x = event.y * 500;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.y += gravity * dt;

    position += velocity * dt;

    if (position.x < 0) {
      position.x = 0;
    } else if (position.x + size.x > gameRef.size.x) {
      position.x = gameRef.size.x - size.x;
    }
  }

  void _stopListeningToAccelerometer() {
    velocity.x = 0;
    gravity = 0;
    jumpSpeed = 0;
  }

  void lose() {
    _stopListeningToAccelerometer();
    gameRef.overlays.add('lose');
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Platform && velocity.y > 0) {
      velocity.y = jumpSpeed;
      gameRef.increaseScore();
    } else if (other is LoseZone) {
      lose();
    }
  }
}
