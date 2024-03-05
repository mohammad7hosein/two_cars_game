import 'dart:ui';

import 'package:flame/components.dart';

class MyCar extends PositionComponent {
  final Color myColor;
  final Vector2 myPosition;

  MyCar(this.myColor, this.myPosition);

  @override
  void onMount() {
    position = myPosition;
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Path getTrianglePath(double x, double y) {
      return Path()
        ..moveTo(0, y)
        ..lineTo(x / 2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);
    }
    canvas.drawPath(getTrianglePath(50, 50), Paint()..color = myColor);
  }

}
