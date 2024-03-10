import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';
import 'package:two_cars_game/my_car.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_square.dart';

enum Shape { Circle, Square }

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late MyCar redCar;
  late MyCar orangeCar;
  late double section;
  late double x1;
  late double x2;
  late double x3;
  late double x4;
  late final Random _random;
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
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('game_background.png')
      ..size = size;
    camera.backdrop.add(background);

    section = (size.x / 4);
    x1 = -(section + section / 2);
    x2 = -section / 2;
    x3 = section / 2;
    x4 = section + section / 2;
    _random = Random();

    redCar = MyCar(position: Vector2(x1, size.y - 500), sprite: 'red_car.png');
    orangeCar = MyCar(position: Vector2(x4, size.y - 500), sprite: 'orange_car.png');
    world.add(redCar);
    world.add(orangeCar);

    _generateGameComponents(0);

    super.onLoad();
  }

  int next(int min, int max) => min + _random.nextInt(max - min);

  void _generateGameComponents(int yPosition) {
    int step1 = 0;
    int step2 = 0;
    for (int i = 0; i < 4; i++) {
      step1 += 200;
      step2 += 300;
      yPosition += step1;
      final y1 = next(yPosition, yPosition + step1);
      final y2 = next(yPosition, yPosition + step2);
      _generateCircleOrSquare(x1, -y1.toDouble(), Colors.red);
      _generateCircleOrSquare(x2, -y2.toDouble(), Colors.red);
      final y3 = next(yPosition, yPosition + step1);
      final y4 = next(yPosition, yPosition + step2);
      _generateCircleOrSquare(x3, -y3.toDouble(), Colors.orangeAccent);
      _generateCircleOrSquare(x4, -y4.toDouble(), Colors.orangeAccent);
    }
  }

  void _generateCircleOrSquare(double x, double y, Color color) {
    final shape = _random.nextBool() ? Shape.Circle : Shape.Square;
    if (shape == Shape.Circle) {
      world.add(MyCircle(color: color, position: Vector2(x, y)));
    } else {
      world.add(MySquare(color: color, position: Vector2(x, y)));
    }
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
        orangeCar.goToX(-section);
      } else {
        orangeCar.goToX(section);
      }
    } else {
      if (redCar.x > -section) {
        redCar.goToX(-section);
      } else {
        redCar.goToX(section);
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
    redCar.position = Vector2(x1, size.y - 500);
    orangeCar.position = Vector2(x4, size.y - 500);
    camera.moveTo(Vector2(0, 0));
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
