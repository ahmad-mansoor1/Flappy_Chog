import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_game/constants.dart';
import 'package:flutter/foundation.dart';

import '../ui/flappy_bird_game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks {


  Ground() : super();

  // bool get isMobile {
  //   if (kIsWeb) return false; // treat web as desktop
  //   return defaultTargetPlatform == TargetPlatform.iOS ||
  //       defaultTargetPlatform == TargetPlatform.android;
  // }

  @override
  Future<void> onLoad() async {

    // final groundHeightMobile = 100.0;
    // final groundHeightDesktop = 150.0;

    // final groundHeight = isMobile ? groundHeightMobile : groundHeightDesktop;

    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load('ground.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;

    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
