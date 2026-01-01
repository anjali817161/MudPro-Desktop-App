import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/left_sidebar.dart';
import 'package:mudpro_desktop_app/modules/daily_report/report_dashboard.dart';

class DailyReportBody extends StatelessWidget {
  const DailyReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        DailySidebar(),
        Expanded(child: DailyDashboard()),
      ],
    );
  }
}
