import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/left_sidebar.dart';
import 'package:mudpro_desktop_app/modules/daily_report/report_dashboard.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/daily_cost/tab_bar/dailycost_tab_view.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/details_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/daily_cost/daily_cost_productview.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/concentration_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/total_cost/daily_total_cost.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/total_cost_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/survey_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/alert_tab.dart';

class DailyReportBody extends StatefulWidget {
  const DailyReportBody({super.key});

  @override
  State<DailyReportBody> createState() => _DailyReportBodyState();
}

class _DailyReportBodyState extends State<DailyReportBody> {
  int _selectedTab = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  Widget _getSelectedTabContent() {
    switch (_selectedTab) {
      case 0:
        return const DailyDashboard();
      case 1:
        return const DetailsTabView();
      case 2:
        return const DailyCostTabView();
      case 3:
        return const DailyTotalCostPage();
      case 4:
        return const ConcentrationTab();
      case 5:
        return const Text("Time Distribution Tab");
      case 6:
        return const SurveyTab();
      case 7:
        return const AlertTab();
      default:
        return const DailyDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DailySidebar(
          selectedTab: _selectedTab,
          onTabSelected: _onTabSelected,
        ),
        Expanded(child: _getSelectedTabContent()),
      ],
    );
  }
}
