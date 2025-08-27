import 'package:flame/components.dart';
import 'package:flappy_bird_game/ui/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background.png');

    // 👇 Make background fit the whole game size
    size = gameRef.size;
    position = Vector2.zero();

    // Render at the very back
    priority = -1;
  }
}
