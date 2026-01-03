import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class DailySidebar extends StatefulWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const DailySidebar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  State<DailySidebar> createState() => _DailySidebarState();
}

class _DailySidebarState extends State<DailySidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: AppTheme.darkPrimaryColor,
      child: Column(
        children: [
          _SideItem(
            title: "Summary",
            selected: widget.selectedTab == 0,
            onTap: () => widget.onTabSelected(0),
          ),
          _SideItem(
            title: "Detail",
            selected: widget.selectedTab == 1,
            onTap: () => widget.onTabSelected(1),
          ),
          _SideItem(
            title: "Daily Cost",
            selected: widget.selectedTab == 2,
            onTap: () => widget.onTabSelected(2),
          ),
          _SideItem(
            title: "Total Cost",
            selected: widget.selectedTab == 3,
            onTap: () => widget.onTabSelected(3),
          ),
          _SideItem(
            title: "Concentration",
            selected: widget.selectedTab == 4,
            onTap: () => widget.onTabSelected(4),
          ),
          _SideItem(
            title: "Time Dist.",
            selected: widget.selectedTab == 5,
            onTap: () => widget.onTabSelected(5),
          ),
          _SideItem(
            title: "Survey",
            selected: widget.selectedTab == 6,
            onTap: () => widget.onTabSelected(6),
          ),
          _SideItem(
            title: "Alert",
            selected: widget.selectedTab == 7,
            onTap: () => widget.onTabSelected(7),
          ),
        ],
      ),
    );
  }
}

class _SideItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _SideItem({
    required this.title,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        color: selected ? const Color(0xff37474f) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}
