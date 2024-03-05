import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_square.dart';

class MyGame extends FlameGame with TapCallbacks {
  late SpriteComponent redCar;
  late SpriteComponent orangeCar;
  late double section;
  late Vector2 carSize;

  // MyGame()
  //     : super(
  //         camera: CameraComponent.withFixedResolution(
  //           width: 400,
  //           height: 850,
  //         ),
  //       );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('game_background.png')
      ..size = size;
    add(background);

    carSize = Vector2(50, 80);
    section = (size.x / 4);
    var startY = size.y - 150;
    var start1 = Vector2(section - carSize.x - 25, startY);
    var start2 = Vector2(4 * section - carSize.x - 25, startY);

    redCar = SpriteComponent()
      ..sprite = await loadSprite('red_car.png')
      ..size = carSize
      ..position = start1;
    add(redCar);
    orangeCar = SpriteComponent()
      ..sprite = await loadSprite('orange_car.png')
      ..size = carSize
      ..position = start2;
    add(orangeCar);

    add(MyCircle(Colors.red, Vector2(section - 60, 50)));
    add(MyCircle(Colors.orangeAccent, Vector2(2 * section - 60, 100)));
    add(MySquare(Colors.red, Vector2(3 * section - 30, 200)));
    add(MySquare(Colors.orangeAccent, Vector2(4 * section - 30, 300)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    redCar.y--;
    orangeCar.y--;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (event.localPosition.x > size.x / 2) {
      if (orangeCar.x > 3 * section) {
        orangeCar.x -= section;
      } else {
        orangeCar.x += section;
      }
    } else {
      if (redCar.x > section) {
        redCar.x -= section;
      } else {
        redCar.x += section;
      }
    }
  }
}
