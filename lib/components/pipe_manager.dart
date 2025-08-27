import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird_game/components/pipes.dart';
import 'package:flappy_bird_game/constants.dart';
import 'package:flappy_bird_game/ui/flappy_bird_game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  double pipeTimer = 0;

  @override
  void update(double dt) {
    pipeTimer += dt;

    if (pipeTimer > pipeInterval) {
      pipeTimer = 0;

      newPipe();
    }
  }

  void newPipe() {
    final double screenHeight = gameRef.size.y;

    final double mixPipeHeight = screenHeight - groundHeight - pipeGap - minPipeHeight;

    // Bottom Pipe Height
    final double bottomPipeHeight = minPipeHeight + Random().nextDouble() * (mixPipeHeight - minPipeHeight);

    // Top Pipe Height
    final double topPipeHeight = screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(Vector2(gameRef.size.x, 0), Vector2(pipeWidth, topPipeHeight), isTopPipe: true);

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
