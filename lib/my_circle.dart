import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyCircle extends PositionComponent {
  final Color color;
  final double radius;
  final _paint = Paint();
  final _innerPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  MyCircle({
    this.radius = 20,
    required this.color,
    required super.position,
  }) : super(
          size: Vector2.all(radius * 2),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox(
      position: size / 2,
      radius: radius,
      anchor: anchor,
      collisionType: CollisionType.passive,
    ));
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      (size / 2).toOffset(),
      radius,
      _paint..color = color,
    );
    canvas.drawCircle(
      (size / 2).toOffset(),
      radius / 1.5,
      _innerPaint,
    );
    super.render(canvas);
  }
}
