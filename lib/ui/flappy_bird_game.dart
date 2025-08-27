// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flappy_bird_game/components/logo.dart';
// import 'package:flutter/material.dart';
//
// import '../components/background.dart';
// import '../components/bird.dart';
// import '../components/ground.dart';
// import '../components/pipe_manager.dart';
// import '../components/pipes.dart';
// import '../components/score.dart';
// import '../constants.dart';
//
// class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
//   late Bird bird;
//   late Background background;
//   late Ground ground;
//   late PipeManager pipeManager;
//   late ScoreText scoreText;
//   late Logo logo;
//
//   @override
//   Future<void> onLoad() async {
//
//     background = Background();
//     await add(background);
//
//
//     bird = Bird();
//     await add(bird);
//
//     ground = Ground();
//     await add(ground);
//
//     logo = Logo();
//     await add(logo);
//
//     pipeManager = PipeManager();
//     await add(pipeManager);
//
//
//     scoreText = ScoreText();
//     await add(scoreText);
//   }
//
//   @override
//   void onTap() {
//     bird.flap();
//   }
//
//   // Score
//
//   int score = 0;
//
//   void incrementScore() {
//     score += 1;
//   }
//
//   // game over
//
//   bool isGameOver = false;
//
//   void gameOver() {
//     if (isGameOver) {
//       return;
//     }
//
//     isGameOver = true;
//     pauseEngine();
//
//     showDialog(
//       context: buildContext!,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text('Game Over'),
//         content: Text('Your Score is $score'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//
//               resetGame();
//             },
//             child: Text('Restart'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void resetGame() {
//     bird.position = Vector2(birdStartX, birdStartY);
//     bird.velocity = 0;
//     score = 0;
//     isGameOver = false;
//     children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
//     resumeEngine();
//   }
// }


import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart'; // for LogicalKeyboardKey, KeyEvent
import 'package:flappy_bird_game/components/logo.dart';
import 'package:flutter/material.dart';

import '../components/background.dart';
import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_manager.dart';
import '../components/pipes.dart';
import '../components/score.dart';
import '../constants.dart';

class FlappyBirdGame extends FlameGame
    with TapDetector, HasCollisionDetection, KeyboardEvents {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  late Logo logo;

  @override
  Future<void> onLoad() async {
    background = Background();
    await add(background);

    bird = Bird();
    await add(bird);

    ground = Ground();
    await add(ground);

    logo = Logo();
    await add(logo);

    pipeManager = PipeManager();
    await add(pipeManager);

    scoreText = ScoreText();
    await add(scoreText);
  }

  @override
  void onTap() {
    bird.flap(); // tap par flap
  }

  // ✅ Keyboard events (new Flame API)
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      // SPACE se flap
      if (event.logicalKey == LogicalKeyboardKey.space) {
        bird.flap();
        return KeyEventResult.handled;
      }

      // ENTER se restart (agar game over hai)
      if (event.logicalKey == LogicalKeyboardKey.enter && isGameOver) {
        resetGame();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  // Score
  int score = 0;

  void incrementScore() {
    score += 1;
  }

  // Game Over
  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your Score is $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;

    // Purane pipes remove karo
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());

    resumeEngine();
  }
}
