import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MyCar extends PositionComponent with CollisionCallbacks {
  final String sprite;
  late Sprite _imageSprite;

  MyCar({
    required super.position,
    required this.sprite,
  }) : super(
          size: Vector2(50, 80),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    _imageSprite = await Sprite.load(sprite);
    add(RectangleHitbox(
      size: size,
      position: size / 2,
      anchor: anchor,
      collisionType: CollisionType.active,
    ));
    super.onLoad();
  }

  @override
  void update(double dt) {
    // position.y--;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    _imageSprite.render(
      canvas,
      size: size,
      position: size / 2,
      anchor: anchor,
    );
    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

    super.onCollision(intersectionPoints, other);
  }

}
