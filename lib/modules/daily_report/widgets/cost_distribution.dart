import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/common_card_widget.dart';

class CostDistributionSection extends StatelessWidget {
  const CostDistributionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return dashboardCard(
      "Cost Distribution",
      Column(
        children: const [
          Expanded(child: HorizontalBarChart("Top 10 Products Used")),
          SizedBox(height: 6),
          Expanded(child: HorizontalBarChart("All Categories")),
        ],
      ),
    );
  }
}

class HorizontalBarChart extends StatelessWidget {
  final String title;
  const HorizontalBarChart(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 11)),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 75, color: Colors.blue)]),
                BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 18, color: Colors.blue)]),
                BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 7, color: Colors.blue)]),
              ],
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
