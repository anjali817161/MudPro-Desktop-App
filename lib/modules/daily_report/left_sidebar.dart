import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class DailySidebar extends StatelessWidget {
  const DailySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: AppTheme.darkPrimaryColor,
      child: Column(
        children: const [
          _SideItem("Summary", true),
          _SideItem("Detail"),
          _SideItem("Daily Cost"),
          _SideItem("Total Cost"),
          _SideItem("Concentration"),
          _SideItem("Time Dist."),
          _SideItem("Survey"),
          _SideItem("Alert"),
        ],
      ),
    );
  }
}

class _SideItem extends StatelessWidget {
  final String title;
  final bool selected;
  const _SideItem(this.title, [this.selected = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: selected ? const Color(0xff37474f) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
