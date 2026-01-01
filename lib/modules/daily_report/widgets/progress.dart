import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/widgets/common_card_widget.dart';
class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return dashboardCard(
      "Progress",
      Column(
        children: const [
          Expanded(child: LineGraph("Depth")),
          Expanded(child: LineGraph("Cum. Total Cost")),
          Expanded(child: LineGraph("Mud Weight")),
        ],
      ),
    );
  }
}

class LineGraph extends StatelessWidget {
  final String title;
  const LineGraph(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 11)),
        Expanded(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 0),
                    FlSpot(1, 2),
                    FlSpot(2, 5),
                    FlSpot(3, 8),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  dotData: FlDotData(show: false),
                ),
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
