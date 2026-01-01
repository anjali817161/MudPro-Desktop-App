import 'package:flutter/material.dart';

class ReportSubTabs extends StatelessWidget {
  const ReportSubTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Row(
        children: const [
          _SubTab("Summary", selected: true),
          _SubTab("Detail"),
          _SubTab("Daily Cost"),
          _SubTab("Total Cost"),
          _SubTab("Concentration"),
          _SubTab("Time Dist."),
          _SubTab("Survey"),
          _SubTab("Alert"),
        ],
      ),
    );
  }
}

class _SubTab extends StatelessWidget {
  final String title;
  final bool selected;
  const _SubTab(this.title, {this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: selected ? Colors.blue : Colors.transparent, width: 2),
        ),
      ),
      child: Text(title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
    );
  }
}
