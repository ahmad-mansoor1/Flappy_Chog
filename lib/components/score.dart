import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../ui/flappy_bird_game.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText() : super(text: '0');

  bool get isMobile {
    if (kIsWeb) return false; // treat web as desktop
    return defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  Future<void> onLoad() async {
    final fontSizeMobile = gameRef.size.x * 0.08;
    final fontSizeDesktop = gameRef.size.x * 0.04;

    textRenderer = TextPaint(
      style: TextStyle(color: Colors.grey.shade900, fontSize: isMobile ? fontSizeMobile : fontSizeDesktop, fontWeight: FontWeight.bold),
    );

    anchor = Anchor.topCenter;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - size.y - 50);

    priority = 5;
  }

  @override
  void update(double dt) {
    final newText = 'Moo Score: ${gameRef.score}';
    if (text != newText) {
      text = newText;
    }
  }
}
