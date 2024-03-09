import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:two_cars_game/my_car.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_square.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late MyCar redCar;
  late MyCar orangeCar;
  late double section;
  late double x1;
  late double x2;
  late double x3;
  late double x4;
  bool _isGamePaused = false;

  final ValueNotifier<int> currentScore = ValueNotifier(0);
  final ValueNotifier<bool> isGameOver = ValueNotifier(false);

  MyGame()
      : super(
        // camera: CameraComponent.withFixedResolution(
        //   width: 600,
        //   height: 1000,
        // ),
        );

  @override
  Future<void> onLoad() async {
    // SpriteComponent background = SpriteComponent()
    //   ..sprite = await loadSprite('game_background.png')
    //   ..position = Vector2(0, 0)
    //   ..size = size
    //   ..anchor = Anchor.center;;

    // final background = await TiledComponent.load(
    //   'background.tmx',
    //   Vector2.all(32),
    // );
    // world.add(background);

    section = (size.x / 4);
    x1 = -(section + section / 2);
    x2 = -section / 2;
    x3 = section / 2;
    x4 = section + section / 2;

    redCar = MyCar(position: Vector2(x1, size.y - 500), sprite: 'red_car.png');
    orangeCar = MyCar(position: Vector2(x4, size.y - 500), sprite: 'orange_car.png');

    world.add(redCar);
    world.add(orangeCar);

    world.add(MyCircle(color: Colors.red, position: Vector2(x1, -600)));
    world.add(MySquare(color: Colors.red, position: Vector2(x2, -400)));
    world.add(MyCircle(color: Colors.orangeAccent, position: Vector2(x3, -200)));
    world.add(MySquare(color: Colors.orangeAccent, position: Vector2(x4, 0)));

    world.add(MyCircle(color: Colors.red, position: Vector2(x1, -1000)));
    world.add(MySquare(color: Colors.red, position: Vector2(x2, -900)));
    world.add(MyCircle(color: Colors.orangeAccent, position: Vector2(x3, -800)));
    world.add(MySquare(color: Colors.orangeAccent, position: Vector2(x4, -700)));

    super.onLoad();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = redCar.position.y;
    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (event.devicePosition.x > 2 * section) {
      if (orangeCar.x > section) {
        orangeCar.x = x3;
      } else {
        orangeCar.x = x4;
      }
    } else {
      if (redCar.x > -section) {
        redCar.x = x1;
      } else {
        redCar.x = x2;
      }
    }
  }

  void increaseScore() {
    currentScore.value++;
  }

  bool get isGamePaused => _isGamePaused;

  bool get isGamePlaying => !_isGamePaused;

  void pauseGame() {
    _isGamePaused = true;
    pauseEngine();
  }

  void resumeGame() {
    _isGamePaused = false;
    resumeEngine();
  }

  void gameOver() {
    redCar.gameOver();
    orangeCar.gameOver();
    Future.delayed(
      const Duration(milliseconds: 1600),
      () => isGameOver.value = true,
    );
  }

  void restartGame() {
    redCar.restart();
    orangeCar.restart();
    isGameOver.value = false;
    currentScore.value = 0;
    // TODO: generate components
  }

  void shake() {
    camera.viewfinder.add(
      MoveEffect.by(
        Vector2(8, 8),
        PerlinNoiseEffectController(
          duration: 1,
          frequency: 400,
        ),
      ),
    );
  }
}
