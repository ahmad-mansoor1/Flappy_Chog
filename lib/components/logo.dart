

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_game/constants.dart';

import '../ui/flappy_bird_game.dart';

class Logo extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks{

  Logo() : super();


  @override
  Future<void> onLoad() async {

    size = Vector2(100, 50);
    position = Vector2(10, 50);
    priority = 10;

    sprite = await Sprite.load('logo_2.png');

    add(RectangleHitbox());

  }


  // @override
  // void update(double dt) {
  //   position.x -= groundScrollSpeed * dt;
  //
  //   if(position.x + size.x / 2 <= 0){
  //     position.x = 0;
  //   }
  //
  //
  //
  // }

}