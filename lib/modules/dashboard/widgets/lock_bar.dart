import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';

class LockBar extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 32,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  c.isLocked.value ? Icons.lock : Icons.lock_open,
                  color: Colors.black87,
                  size: 18,
                ),
                onPressed: c.toggleLock,
              ),
            ],
          ),
        ));
  }
}