import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

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

  void exploit() {
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 80;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          count: 40,
          lifespan: 0.8,
          generator: (i) {
            return AcceleratedParticle(
              speed: randomVector2(),
              acceleration: randomVector2(),
              child: MovingParticle(
                to: randomVector2(),
                child: ComputedParticle(renderer: (canvas, particle) {
                  canvas.drawRect(
                    Rect.fromCenter(
                      center: const Offset(5, 5),
                      width: 10,
                      height: 10,
                    ),
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
