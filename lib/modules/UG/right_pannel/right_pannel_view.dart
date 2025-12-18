import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/formation_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory_alert_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory_report_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/pad_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/pit_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/pump_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/sce_view.dart';

class UGRightPanel extends StatelessWidget {
  final c = Get.find<UgController>();

  final tabs = const [
    'pad',
    'inventory',
    'pit',
    'pump',
    'sce',
    'formation',
    'report',
    'alert',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ───── TOP TAB BAR ─────
        Container(
          height: 36,
          color: const Color(0xffE6E6E6),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tabs.map(_tabButton).toList(),
                  ),
                ),
              ),
              IconButton(
                icon: Obx(() => Icon(
                      c.isLocked.value ? Icons.lock : Icons.lock_open,
                      size: 18,
                    )),
                onPressed: c.toggleLock,
              )
            ],
          ),
        ),

        // ───── TAB CONTENT ─────
        Expanded(
          child: Obx(() {
            switch (c.activeRightTab.value) {
              case 'pad':
                return PadView();
              case 'inventory':
                return InventoryView();
              case 'pit':
                return PitView();
                case 'pump':
                return PumpView();
                case 'sce':
                return SceView();
                case 'formation':
                return FormationView();
                case 'report':
                return ReportView();
                case 'alert':
                return AlertView();
                
              default:
                return const Center(child: Text('Coming Soon'));
            }
          }),
        ),
      ],
    );
  }

  Widget _tabButton(String id) {
    return Obx(() {
      final selected = c.activeRightTab.value == id;
      return InkWell(
        onTap: () => c.switchRightTab(id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: selected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            id.toUpperCase(),
            style: const TextStyle(fontSize: 11),
          ),
        ),
      );
    });
  }
}
