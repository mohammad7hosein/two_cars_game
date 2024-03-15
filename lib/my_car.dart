import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:two_cars_game/my_circle.dart';
import 'package:two_cars_game/my_game.dart';
import 'package:two_cars_game/my_square.dart';

const orangeColor = Color(0xFFFF9955);
const redColor = Color(0xFFE44545);

class MyCar extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  final Color color;
  final String sprite;
  late Sprite _imageSprite;
  bool _isGameOver = false;
  final _paint = Paint();
  final rnd = Random();

  MyCar({
    required super.position,
    required this.sprite,
    required this.color,
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

  double _velocity = 2;

  @override
  void update(double dt) {
    if (!_isGameOver) {
      position.y -= _velocity;
      if (_velocity > 10) {
        _velocity += 0.05 * dt;
      } else {
        _velocity += 0.1 * dt;
      }
      smoke();
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

  void smoke() {
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 20;
    parent!.add(
      ParticleSystemComponent(
        position: position + Vector2(-3, 36),
        particle: Particle.generate(
          count: 2,
          lifespan: 0.2,
          generator: (i) {
            return MovingParticle(
              to: randomVector2(),
              child: ComputedParticle(renderer: (canvas, particle) {
                canvas.drawRect(
                  Vector2(7, 7).toRect(),
                  _paint
                    ..color = color.withOpacity(
                      1 - particle.progress,
                    ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is MyCircle) {
      FlameAudio.play('collect.wav');
      other.removeCircle();
      gameRef.increaseScore();
      gameRef.checkToGenerateNextPattern(other);
    } else if (other is MySquare) {
      FlameAudio.play('explosion.wav');
      other.exploit();
      gameRef.shake();
      gameRef.gameOver();
    }
    super.onCollision(intersectionPoints, other);
  }

  void goToLeft(double x) {
    add(RotateEffect.by(
      -pi / 6,
      EffectController(duration: 0.1),
    ));
    add(MoveByEffect(
      Vector2(x, 0),
      EffectController(duration: 0.3),
    ));
    add(RotateEffect.by(
      pi / 6,
      EffectController(duration: 0.5),
    ));
  }

  void goToRight(double x) {
    add(RotateEffect.by(
      pi / 6,
      EffectController(duration: 0.1),
    ));
    add(MoveByEffect(
      Vector2(x, 0),
      EffectController(duration: 0.3),
    ));
    add(RotateEffect.by(
      -pi / 6,
      EffectController(duration: 0.5),
    ));
  }

  void gameOver() {
    _isGameOver = true;
  }

  void restart() {
    _velocity = 2;
    _isGameOver = false;
  }
}
