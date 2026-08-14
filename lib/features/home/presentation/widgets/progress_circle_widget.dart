import 'package:flutter/material.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';

class ProgressCircleWidget extends StatelessWidget {
  final int done;
  final int total;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const ProgressCircleWidget({
    super.key,
    required this.done,
    required this.total,
    this.size = 100.0,
    this.activeColor = AppColors.green,
    this.inactiveColor = const Color(0xFFD5E5DC),
  });

  @override
  Widget build(BuildContext context) {
    final double progress = done / total;
    final int segments = total > 0 ? total : 1;
    final int activeSegments = (progress * segments).round();

    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 8.0),
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: ProgressPainter(
            activeSegments: activeSegments,
            totalSegments: segments,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$done',
                    style: TextStyle(
                      fontSize: size * 0.25,
                      fontWeight: FontWeight.bold,
                      color: done > 0 ? AppColors.green : AppColors.grayText,
                    ),
                  ),
                  TextSpan(
                    text: '/$total',
                    style: TextStyle(
                      fontSize: size * 0.25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final int activeSegments;
  final int totalSegments;
  final Color activeColor;
  final Color inactiveColor;

  ProgressPainter({
    required this.activeSegments,
    required this.totalSegments,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    for (int i = 0; i < totalSegments; i++) {
      final startAngle = 2 * 3.14159 * i / totalSegments - 3.14159 / 2;
      final sweepAngle =
          2 * 3.14159 / totalSegments * (totalSegments > 1 ? 0.97 : 0.99);
      paint.color = i < activeSegments ? activeColor : inactiveColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
