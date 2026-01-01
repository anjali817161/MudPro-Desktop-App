import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/cost_distribution.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/kpi_section.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/progress.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/wellbore.dart';

class DailyDashboard extends StatelessWidget {
  const DailyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: const [
          Expanded(flex: 2, child: WellboreSection()),
          SizedBox(width: 8),
          Expanded(flex: 1, child: KPISection()),
          SizedBox(width: 8),
          Expanded(flex: 2, child: CostDistributionSection()),
          SizedBox(width: 8),
          Expanded(flex: 2, child: ProgressSection()),
        ],
      ),
    );
  }
}

