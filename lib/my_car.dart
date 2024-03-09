import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_game.dart';
import 'package:two_cars_game/my_square.dart';

class MyCar extends PositionComponent with CollisionCallbacks, HasGameRef<MyGame> {
  final String sprite;
  late Sprite _imageSprite;
  bool _isGameOver = false;

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

  double _velocity = 40;

  @override
  void update(double dt) {
    if (!_isGameOver) {
      _velocity += 10 * dt;
      position.y -= _velocity * dt;
    }
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
    if (other is MyCircle) {
      other.removeFromParent();
      gameRef.increaseScore();
    } else if (other is MySquare) {
      other.exploit();
      gameRef.shake();
      gameRef.gameOver();
    }
    super.onCollision(intersectionPoints, other);
  }

  void gameOver() {
    _isGameOver = true;
  }

  void restart() {
    _isGameOver = false;
  }
}
