import 'package:flutter/material.dart';

class DailyReportTopBar extends StatelessWidget {
  const DailyReportTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      color: const Color(0xff1976d2),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔹 LEFT ALIGNED TABS
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _TopTab("Home"),
                _TopTab("Report"),
                _TopTab("Utilities"),
                _TopTab("Help"),
              ],
            ),
          ),

          /// 🔹 CENTER HEADING
          const Text(
            "MUDPRO+  Daily Report",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  final String title;
  const _TopTab(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}

