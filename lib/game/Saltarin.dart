import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saltarin/components/background.dart';
import 'package:saltarin/components/platformManager.dart';
import 'package:saltarin/components/player.dart';
import 'package:saltarin/components/lose_zone.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';


class Saltarin extends FlameGame with HasCollisionDetection {
  late PlatformManager platformManager;
  late Player player;
  late bool gameOverState = false;

  int score = 0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final screenSize = size;

    platformManager = PlatformManager(screenSize);
    player = Player(
      position: Vector2(screenSize.x / 2 - 25, screenSize.y - 100),
      size: Vector2(50, 50),
    );

    scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(10, 10),
      priority: 10,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 48,
          color: Colors.black,
        ),
      ),
    );
    add(scoreText);

    addAll([Background(), platformManager, player]);
    void addLoseZone() {
      add(LoseZone(
        position: Vector2(0, screenSize.y - 20),
        size: Vector2(screenSize.x, 20),
      ));
    }

    addLoseZone();
    overlays.addEntry('lose', (context, game) => _buildLoseOverlay(Saltarin()));
  }

  void increaseScore() {
    score += 1;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameOverState) {
      platformManager.update(dt);
    }
    scoreText.text = 'Score: $score';
  }



}

Widget _buildLoseOverlay(Saltarin game) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '¡Perdiste!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              SystemNavigator.pop(); 
            },
            child: const Text('Salir'),
          ),
        ],
      ),
    ),
  );
}


@override
Widget buildOverlay(String overlayKey) {
  switch (overlayKey) {
    case 'lose':
      return Center(
        child: Container(
          color: Colors.black54,
          child: const Text(
            'Perdiste!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
  return const SizedBox.shrink();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Saltarin game = Saltarin();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(game : game),
      ),
    ),
  );
}

