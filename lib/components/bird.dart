import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_game/components/pipes.dart';

import '../constants.dart';
import '../ui/flappy_bird_game.dart';
import 'ground.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  // Initialize Bird position & Size
  Bird() : super(position: Vector2(birdStartX, birdStartY), size: Vector2(birdWidth, birdHeight));

  double velocity = 0;

  // final double gravity = 200;
  // final double jumpStrength = -300;

  @override
  Future<void> onLoad() async {
    // sprite = await Sprite.load('red_bird.png');
    sprite = await Sprite.load('bird.png');

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
