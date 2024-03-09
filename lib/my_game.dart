import 'package:flame/events.dart';
import 'package:flame/game.dart';
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

  MyGame()
      : super(
        // camera: CameraComponent.withFixedResolution(
        //   width: 600,
        //   height: 1000,
        // ),
        );

  @override
  Color backgroundColor() => Colors.white60;

  @override
  Future<void> onLoad() async {
    // SpriteComponent background = SpriteComponent()
    //   ..sprite = await loadSprite('game_background.png')
    //   ..position = Vector2(0, 0)
    //   ..size = size
    //   ..anchor = Anchor.center;
    // world.add(background);
    debugMode = true;
    section = (size.x / 4);
    x1 = -(section + section / 2);
    x2 = -section / 2;
    x3 = section / 2;
    x4 = section + section / 2;

    redCar = MyCar(position: Vector2(x1, 0), sprite: 'red_car.png');
    orangeCar = MyCar(position: Vector2(x3, 0), sprite: 'orange_car.png');

    world.add(redCar);
    world.add(orangeCar);
    world.add(MyCircle(color: Colors.red, position: Vector2(x1, 100)));
    world.add(MyCircle(color: Colors.orangeAccent, position: Vector2(x2, 150)));
    world.add(MySquare(color: Colors.red, position: Vector2(x3, 200)));
    world.add(MySquare(color: Colors.orangeAccent, position: Vector2(x4, 250)));
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
}
