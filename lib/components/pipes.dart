import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_game/constants.dart';

import '../ui/flappy_bird_game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;

  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe}) : super(size: size, position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;

    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;

      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
