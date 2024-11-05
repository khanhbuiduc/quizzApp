// CustomPainter for drawing the line
import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset box1Position;
  final Offset? lineEndPosition;

  LinePainter(this.box1Position, this.lineEndPosition);

  @override
  void paint(Canvas canvas, Size size) {
    if (lineEndPosition != null) {
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final box1Center = box1Position + Offset(25, 25); // Center of Box 1

      // Draw the line from Box 1 center to current touch position
      canvas.drawLine(box1Center, lineEndPosition!, paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.lineEndPosition != lineEndPosition;
  }
}
