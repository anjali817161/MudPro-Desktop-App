import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/right_section/survey/survey_3d_tab.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/right_section/survey/survey_data_tab.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/right_section/survey/survey_dogleg_tab.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/right_section/survey/survey_plan_tab.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/right_section/survey/survey_section_tab.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class SurveyView extends StatelessWidget {
  SurveyView({super.key});

  final RxInt selectedTab = 0.obs;

  final List<Map<String, dynamic>> tabs = const [
    {"label": "Data", "icon": Icons.table_chart},
    {"label": "Section", "icon": Icons.account_tree},
    {"label": "Plan", "icon": Icons.timeline},
    {"label": "Dogleg", "icon": Icons.show_chart},
    {"label": "3D", "icon": Icons.rotate_90_degrees_ccw},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _tabBar(),
          const SizedBox(height: 1),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
              ),
              child: Obx(() {
                switch (selectedTab.value) {
                  case 0:
                    return SurveyDataTab();
                  case 1:
                    return const SectionViewChart(points: [],);
                  case 2:
                    return const SurveyPlanTab();
                  case 3:
                    return const SurveyDoglegTab();
                  case 4:
                    return const Survey3DTab();
                  default:
                    return SurveyDataTab();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TAB BAR =================
  Widget _tabBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            const SizedBox(width: 8),
            ...List.generate(tabs.length, (i) {
              final active = selectedTab.value == i;
              return GestureDetector(
                onTap: () => selectedTab.value = i,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: active ? AppTheme.primaryColor : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tabs[i]['icon'],
                        size: 16,
                        color: active ? AppTheme.primaryColor : AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tabs[i]['label'],
                        style: AppTheme.bodySmall.copyWith(
                          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                          color: active ? AppTheme.primaryColor : AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(right: 12),
              child: Obx(() {
                final activeTabName = tabs[selectedTab.value]['label'];
                return Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      activeTabName,
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}