import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/base_secondary_tababr.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import '../controller/dashboard_controller.dart';

class UtilitySecondaryTabbar extends StatelessWidget {
  UtilitySecondaryTabbar({super.key});

  final controller = Get.find<DashboardController>();

  final tabs = const [
    {"title": "Engineering Tools", "icon": Icons.handyman},
    {"title": "Unit Conversion", "icon": Icons.swap_horiz},
    {"title": "Calculator", "icon": Icons.calculate},
    {"title": "Notepad", "icon": Icons.note},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseSecondaryTabBar(
      tabs: tabs,
      onTap: (index) {
        controller.activeSecondaryTab.value = index;

        // 🔹 Future overlay/page open logic yahin add karna
        // controller.openOverlay(EngineeringToolsPage());
      }, activeIndex: controller.activeUtilityTab,
    );
  }
}
