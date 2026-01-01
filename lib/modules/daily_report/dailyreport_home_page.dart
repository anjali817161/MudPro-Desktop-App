import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/daily_report_body.dart';
import 'package:mudpro_desktop_app/modules/daily_report/report_subtabs.dart';
import 'package:mudpro_desktop_app/modules/daily_report/report_topbar.dart';

class DailyReportPage extends StatelessWidget {
  const DailyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      body: Column(
        children: const [
          DailyReportTopBar(),
          ReportSubTabs(),
          Expanded(child: DailyReportBody()),
        ],
      ),
    );
  }
}
