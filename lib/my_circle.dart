import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MyCircle extends PositionComponent {
  final Color color;
  final double radius;
  final _paint = Paint();

  MyCircle({
    this.radius = 20,
    required this.color,
    required super.position,
  }) : super(
          size: Vector2.all(radius * 2),
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
      size.toOffset(),
      radius,
      _paint..color = color,
    );
    super.render(canvas);
  }
}
