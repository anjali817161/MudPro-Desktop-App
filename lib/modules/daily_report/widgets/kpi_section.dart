import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/common_card_widget.dart';

import 'package:fl_chart/fl_chart.dart';

class KPISection extends StatelessWidget {
  const KPISection({super.key});

  @override
  Widget build(BuildContext context) {
    return dashboardCard(
      "KPI",
      Column(
        children: const [
          Expanded(child: GaugeWidget("Depth", 0.96)),
          Expanded(child: GaugeWidget("Cost", 0.38)),
          Expanded(child: GaugeWidget("Day", 0.21)),
        ],
      ),
    );
  }
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double value;

  const GaugeWidget(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11)),
        Expanded(
          child: PieChart(
            PieChartData(
              startDegreeOffset: 180,
              sectionsSpace: 0,
              centerSpaceRadius: 35,
              sections: [
                PieChartSectionData(
                  value: value,
                  color: Colors.amber,
                  radius: 12,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: 1 - value,
                  color: Colors.grey.shade300,
                  radius: 12,
                  showTitle: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
