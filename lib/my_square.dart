import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';

class MySquare extends PositionComponent {
  final Color myColor;
  final Vector2 myPosition;

  MySquare(this.myColor, this.myPosition);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = myPosition;
    size = Vector2.all(30);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y),
        Paint()..color = myColor);
  }
}
