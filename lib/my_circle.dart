import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';

class MyCircle extends PositionComponent {
  final Color myColor;
  final Vector2 myPosition;

  MyCircle(this.myColor, this.myPosition);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = myPosition;
    size = Vector2.all(20);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(size.toOffset(), 20, Paint()..color = myColor);
  }
}
