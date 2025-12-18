import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class ReportView extends StatelessWidget {
  ReportView({super.key});

  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= LEFT SECTION =================
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Factors Considered in Hydraulics Calculation',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(height: 16),

                _check('ROP', c.considerROP),
                _check('RPM', c.considerRPM),
                _check('Eccentricity', c.considerEccentricity),
              ],
            ),
          ),

          const SizedBox(width: 80),

          // ================= RIGHT SECTION =================
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Rheology',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(height: 16),

                _check('Multi-rheology', c.multiRheology),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= CHECK ROW =================
  Widget _check(String text, RxBool value) {
    return Obx(() => Row(
          children: [
            Checkbox(
              value: value.value,
              onChanged: c.isLocked.value
                  ? null
                  : (v) => value.value = v!,
              visualDensity: VisualDensity.compact,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ));
  }
}
