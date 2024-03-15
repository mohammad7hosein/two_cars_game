import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';
import 'package:two_cars_game/my_car.dart';
import 'package:two_cars_game/patterns.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late MyCar redCar;
  late MyCar orangeCar;
  late double section;
  late double x1;
  late double x2;
  late double x3;
  late double x4;
  bool _isGamePaused = false;
  final Random _random = Random();
  final List<PositionComponent> _gameComponents = [];

  final ValueNotifier<int> currentScore = ValueNotifier(0);
  final ValueNotifier<bool> isGameOver = ValueNotifier(false);

  MyGame() : super();

  @override
  Future<void> onLoad() async {
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('game_background.png')
      ..size = size;
    camera.backdrop = background;

    section = (size.x / 4);
    x1 = -(section + section / 2);
    x2 = -section / 2;
    x3 = section / 2;
    x4 = section + section / 2;

    redCar = MyCar(
      position: Vector2(x1, size.y - 500),
      sprite: 'red_car.png',
      color: redColor,
    );
    orangeCar = MyCar(
      position: Vector2(x4, size.y - 500),
      sprite: 'orange_car.png',
      color: orangeColor,
    );
    world.add(redCar);
    world.add(orangeCar);
    _generateGameComponents(250);

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
        orangeCar.goToLeft(-section);
      } else {
        orangeCar.goToRight(section);
      }
    } else {
      if (redCar.x > -section) {
        redCar.goToLeft(-section);
      } else {
        redCar.goToRight(section);
      }
    }
  }

  void _addComponentToTheGame(PositionComponent component) {
    world.add(component);
    _gameComponents.add(component);
  }

  void _generateGameComponents(double yPosition) {
    generatePattern(_random.nextInt(8) + 1, redColor, x1, x2, yPosition)
        .forEach((element) {
      _addComponentToTheGame(element);
    });
    generatePattern(_random.nextInt(8) + 1, orangeColor, x3, x4, yPosition + 50)
        .forEach((element) {
      _addComponentToTheGame(element);
    });
  }

  void checkToGenerateNextPattern(PositionComponent component) {
    final length = _gameComponents.length;
    for (int i = 0; i < length; i++) {
      if (component == _gameComponents[i] && i >= length - 30) {
        _generateGameComponents(_gameComponents.last.position.y - 50);
        _tryToGarbageCollect(component);
      }
    }
  }

  void _tryToGarbageCollect(PositionComponent component) {
    for (int i = 0; i < _gameComponents.length; i++) {
      if (component == _gameComponents[i] && i >= 50) {
        _removeComponentsFromGame(10);
        break;
      }
    }
  }

  void _removeComponentsFromGame(int n) {
    for (int i = n - 1; i >= 0; i--) {
      _gameComponents[i].removeFromParent();
      _gameComponents.removeAt(i);
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
    _removeComponentsFromGame(_gameComponents.length);
    redCar.restart();
    orangeCar.restart();
    redCar.position = Vector2(x1, size.y - 500);
    orangeCar.position = Vector2(x4, size.y - 500);
    camera.moveTo(Vector2(0, 0));
    isGameOver.value = false;
    currentScore.value = 0;
    _generateGameComponents(250);
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
