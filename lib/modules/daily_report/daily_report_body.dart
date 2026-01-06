import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/left_sidebar.dart';
import 'package:mudpro_desktop_app/modules/daily_report/report_dashboard.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/alert/alert_page.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/concentration_tab/concentration_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/daily_cost/tab_bar/dailycost_tab_view.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/details_tab.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/daily_cost/daily_cost_productview.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/survey/survey_page.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/time_distribution/time_distribution_page.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/total_cost/daily_total_cost.dart';

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
        return const ConcentrationPage();
      case 5:
        return const TimeDistributionPage();
      case 6:
        return const SurveyPage();
      case 7:
        return const AlertMainTabPage();
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
