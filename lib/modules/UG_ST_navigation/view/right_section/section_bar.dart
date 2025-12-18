import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/controller/UG_ST_controller.dart';

class RightTopTabs extends StatelessWidget {
  final c = Get.find<UgStController>();

  final tabs = const [
    "Well",
    "Casing",
    "Interval",
    "Plan",
    "Survey",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: const Color(0xffDADADA),
      child: Row(
        children: [
          ...List.generate(tabs.length, (i) {
            return Obx(() {
              final active = c.selectedWellTab.value == i;
              return InkWell(
                onTap: () => c.switchWellTab(i),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: active ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          active ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            });
          }),

          const Spacer(),

          // 🔒 LOCK ICON
          Obx(() => IconButton(
                icon: Icon(
                  c.isLocked.value ? Icons.lock : Icons.lock_open,
                  size: 18,
                ),
                onPressed: c.toggleLock,
              )),
        ],
      ),
    );
  }
}
