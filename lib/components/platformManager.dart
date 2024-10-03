import 'package:flame/components.dart';
import 'dart:math';
import 'platform.dart';
import 'cloud.dart';

class PlatformManager extends Component {
  final Vector2 screenSize;
  List<Platform> platforms = [];
  Random random = Random();

  double platformSpacing = 50;
  double fallSpeed = 90;

  PlatformManager(this.screenSize);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    for (int i = 0; i < 20; i++) {
      createPlatform(screenSize.y - i * platformSpacing);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Hacer que las plataformas caigan
    for (var platform in platforms) {
      platform.position.y += fallSpeed * dt;
    }

    // Eliminar las plataformas que salen de la pantalla
    platforms.removeWhere((platform) {
      return platform.position.y > screenSize.y;
    });

    // Crear nuevas plataformas o nubes si es necesario
    if (platforms.isEmpty || platforms.last.position.y > platformSpacing) {
      createPlatform(-platformSpacing);
    }
  }

  void createPlatform(double y) {
    double x = random.nextDouble() * (screenSize.x - 100);

    // Determinar aleatoriamente si creamos una plataforma normal o una nube
    bool createCloud =
        random.nextBool(); // 50% de probabilidad de crear una nube

    if (createCloud) {
      Cloud cloud = Cloud(
        position: Vector2(x, y),
        size: Vector2(100, 20),
      );
      add(cloud);
      platforms.add(cloud);
    } else {
      Platform platform = Platform(
        position: Vector2(x, y),
        size: Vector2(100, 20),
      );
      add(platform);
      platforms.add(platform);
    }
  }
}
