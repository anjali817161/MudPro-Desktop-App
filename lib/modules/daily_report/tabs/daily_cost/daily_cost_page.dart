import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/daily_report/model/cost_model.dart';
import 'package:mudpro_desktop_app/modules/daily_report/tabs/daily_cost/widget/horizontal_bar.dart';

class DailyCostPage extends StatelessWidget {
  const DailyCostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = [
      CostData('BARITE 4.1 - BIG BAG', 77.5),
      CostData('BENTONITE - TON', 18.8),
      CostData('CAUSTIC SODA', 1.9),
      CostData('SODA ASH', 1.9),
    ];

    final groupData = [
      CostData('Weight Material', 77.5),
      CostData('Viscosifier', 18.8),
      CostData('Common Chemical', 3.8),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: HorizontalBarChart(
                        title: 'Daily Cost Distribution - Product',
                        data: productData,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: HorizontalBarChart(
                        title: 'Daily Cost Distribution - Group',
                        data: groupData,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: HorizontalBarChart(
                        title: 'Daily Cost Distribution - Product',
                        data: productData,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: HorizontalBarChart(
                        title: 'Daily Cost Distribution - Group',
                        data: groupData,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
