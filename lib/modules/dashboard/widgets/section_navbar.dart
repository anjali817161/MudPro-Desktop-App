import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';

class SectionNavBar extends StatelessWidget {
  final tabs = ["Well", "Mud", "Pump", "Operation", "Pit", "Safety", "Remarks", "JSA"];
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: Colors.grey.shade300,
      child: Obx(() => Row(
            children: List.generate(tabs.length, (i) {
              return GestureDetector(
                onTap: () => c.activeSectionTab.value = i,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.activeSectionTab.value == i
                        ? Colors.white
                        : Colors.grey.shade300,
                    border:
                        const Border(right: BorderSide(color: Colors.black12)),
                  ),
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: c.activeSectionTab.value == i
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}