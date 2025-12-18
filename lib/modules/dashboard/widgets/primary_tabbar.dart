import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';

class PrimaryTabBar extends StatelessWidget {
  PrimaryTabBar({super.key});

  final controller = Get.find<DashboardController>();
  final tabs = ["Home", "Report", "Utility", "Help"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: const Color(0xffE6E6E6),
      child: Obx(
        () => Row(
          children: List.generate(tabs.length, (index) {
            final isActive = controller.activePrimaryTab.value == index;

            return GestureDetector(
              onTap: () => controller.activePrimaryTab.value = index,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                    right: const BorderSide(color: Colors.black12),
                  ),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}