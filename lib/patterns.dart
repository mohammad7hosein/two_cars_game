import 'dart:ui';

import 'package:flame/components.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_square.dart';

const double space = 220;

List<dynamic> generate1(Color color, double left, double right, double y) {
  return [
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
  ];
}
