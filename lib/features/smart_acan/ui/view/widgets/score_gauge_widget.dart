import 'package:flutter/material.dart';
import 'dart:math';

class ScoreGaugeWidget extends StatelessWidget {
  final double percentage;
  final String label;
  final Color color; // ✅ جديد

  const ScoreGaugeWidget({
    super.key,
    this.percentage = 92,
    this.label = 'درجة الاحتمال',
    this.color = const Color(0xFFC2487A), // ✅ default
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: _GaugePainter(percentage: percentage, color: color), // ✅
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${percentage.toInt()}%',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: color, // ✅
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage;
  final Color color; // ✅ جديد

  _GaugePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final trackPaint = Paint()
      ..color = color
          .withValues(alpha: 0.2) // ✅ نفس اللون بس شفاف
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color =
          color // ✅
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      oldDelegate.percentage != percentage || oldDelegate.color != color; // ✅
}
