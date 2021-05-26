import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DigitalInkPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);
    canvas.drawColor(Colors.teal[100]!, BlendMode.multiply);
  
  }

  @override
  bool shouldRepaint(DigitalInkPainter oldPainter) {
    return false;
  
  }
}
