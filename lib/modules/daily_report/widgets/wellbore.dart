import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/common_card_widget.dart';

class WellboreSection extends StatelessWidget {
  const WellboreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return dashboardCard(
      "Wellbore Schematic",
      CustomPaint(
        painter: WellborePainter(),
        child: Container(),
      ),
    );
  }
}

class WellborePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 6;

    final centerX = size.width / 2;

    // Outer casing
    canvas.drawLine(
        Offset(centerX - 20, 20), Offset(centerX - 20, size.height - 20), paint);
    canvas.drawLine(
        Offset(centerX + 20, 20), Offset(centerX + 20, size.height - 20), paint);

    // Inner pipe
    paint.strokeWidth = 3;
    canvas.drawLine(
        Offset(centerX, 40), Offset(centerX, size.height - 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
