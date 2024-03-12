import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class MySquare extends PositionComponent {
  final Color color;
  final _paint = Paint();
  final _innerPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

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
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        size.toRect(),
        const Radius.circular(10),
      ),
      _paint..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: const Offset(20, 20),
          width: 25,
          height: 25,
        ),
        const Radius.circular(5),
      ),
      _innerPaint,
    );
  }

  void exploit() {
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 100;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          count: 70,
          lifespan: 0.7,
          generator: (i) {
            return AcceleratedParticle(
              speed: randomVector2(),
              acceleration: randomVector2(),
              child: MovingParticle(
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
              ),
            );
          },
        ),
      ),
    );
    removeFromParent();
  }
}
