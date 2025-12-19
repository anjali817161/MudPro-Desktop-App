import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/model/UG_ST_model.dart';

class SectionViewChart extends StatelessWidget {
  final List<SectionPoint> points;

  const SectionViewChart({
    super.key,
    required this.points,
  });

  // Demo data for the chart
  static final List<SectionPoint> demoPoints = [
    SectionPoint(0, 0),
    SectionPoint(1000, 500),
    SectionPoint(2000, 1200),
    SectionPoint(3000, 2100),
    SectionPoint(4000, 3200),
    SectionPoint(5000, 4500),
    SectionPoint(6000, 6000),
    SectionPoint(7000, 7700),
    SectionPoint(8000, 9600),
    SectionPoint(9000, 11700),
    SectionPoint(10000, 14000),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // ================= TITLE =================
          const Text(
            "Section View",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          // ================= CHART =================
          Expanded(
            child: LineChart(
              _chartData(),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _chartData() {
    return LineChartData(
      backgroundColor: Colors.white,

      // ================= GRID =================
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.black12, strokeWidth: 1),
        getDrawingVerticalLine: (value) =>
            FlLine(color: Colors.black12, strokeWidth: 1),
      ),

      // ================= AXIS =================
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          axisNameWidget: const Text(
            "TVD (ft)",
            style: TextStyle(fontSize: 10),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 2000,
            getTitlesWidget: (v, _) =>
                Text(v.toInt().toString(), style: const TextStyle(fontSize: 9)),
          ),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const Text(
            "Horizontal Displacement (ft)",
            style: TextStyle(fontSize: 10),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 2000,
            getTitlesWidget: (v, _) =>
                Text(v.toInt().toString(), style: const TextStyle(fontSize: 9)),
          ),
        ),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),

      // ================= BOUNDS =================
      minX: 0,
      maxX: 10000,
      minY: 0,
      maxY: 10000,

      // ================= LINE =================
      lineBarsData: [
        LineChartBarData(
          spots: (points.isNotEmpty ? points : demoPoints)
              .map((e) => FlSpot(e.hd, e.tvd))
              .toList(),
          isCurved: true,
          color: Colors.red.shade700,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }
}
