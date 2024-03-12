import 'dart:ui';

import 'package:flame/components.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_square.dart';

const double space = 220;

List<dynamic> generatePattern(
    int pattern, Color color, double left, double right, double y) {
  switch (pattern) {
    case 1:
      return generate1(color, left, right, y);
    case 2:
      return generate2(color, left, right, y);
    case 3:
      return generate3(color, left, right, y);
    case 4:
      return generate4(color, left, right, y);
    case 5:
      return generate5(color, left, right, y);
    case 6:
      return generate6(color, left, right, y);
    case 7:
      return generate7(color, left, right, y);
    case 8:
      return generate8(color, left, right, y);
    default:
      return generate1(color, left, right, y);
  }
}

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

List<dynamic> generate2(Color color, double left, double right, double y) {
  return [
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
  ];
}

List<dynamic> generate3(Color color, double left, double right, double y) {
  return [
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
  ];
}

List<dynamic> generate4(Color color, double left, double right, double y) {
  return [
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
  ];
}

List<dynamic> generate5(Color color, double left, double right, double y) {
  return [
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
  ];
}

List<dynamic> generate6(Color color, double left, double right, double y) {
  return [
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
  ];
}

List<dynamic> generate7(Color color, double left, double right, double y) {
  return [
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
  ];
}

List<dynamic> generate8(Color color, double left, double right, double y) {
  return [
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(right, y -= space)),
    MyCircle(color: color, position: Vector2(left, y -= space)),
    MySquare(color: color, position: Vector2(left, y -= space)),
  ];
}
