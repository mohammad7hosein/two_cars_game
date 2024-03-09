import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MySquare extends PositionComponent {
  final Color color;
  final _paint = Paint();

  MySquare({
    required this.color,
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(40),
        );

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: size / 2,
      size: size,
      anchor: anchor,
      collisionType: CollisionType.passive,
    ));
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      size.toRect(),
      _paint..color = color,
    );
  }
}
