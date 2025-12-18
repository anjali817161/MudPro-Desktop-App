import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class AlertView extends StatelessWidget {
  AlertView({super.key});
  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= LEFT PANEL =================
          SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ---------- SAFETY MARGIN INPUT ----------
                Row(
                  children: [
                    const Text('Safety Margin', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 70,
                      height: 24,
                      child: Obx(() => TextField(
                            enabled: !c.isLocked.value,
                            controller: TextEditingController(
                              text: c.safetyMargin.value,
                            ),
                            onChanged: (v) => c.safetyMargin.value = v,
                            style: const TextStyle(fontSize: 11),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            ),
                          )),
                    ),
                    const SizedBox(width: 4),
                    const Text('(%)', style: TextStyle(fontSize: 11)),
                  ],
                ),

                const SizedBox(height: 10),

                // ---------- DYNAMIC BAR ----------
                Obx(() {
                  final value =
                      double.tryParse(c.safetyMargin.value) ?? 0;

                  final green = value.clamp(0, 80);
                  final yellow =
                      value > 80 ? (value.clamp(80, 100) - 80) : 0;
                  final red = value > 100 ? value - 100 : 0;

                  return Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Row(
                      children: [
                        if (green > 0)
                          Expanded(
                            flex: (green * 10).toInt(),
                            child: const ColoredBox(
                                color: Color(0xff1E7F3F)),
                          ),
                        if (yellow > 0)
                          Expanded(
                            flex: (yellow * 10).toInt(),
                            child: const ColoredBox(
                                color: Color(0xffE6C300)),
                          ),
                        if (red > 0)
                          Expanded(
                            flex: (red * 10).toInt(),
                            child: const ColoredBox(
                                color: Color(0xffC62828)),
                          ),
                        // remaining empty
                        Expanded(
                          flex: ((100 - value.clamp(0, 100)) * 10).toInt(),
                          child: const SizedBox(),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 12),

                // ---------- LEGEND ----------
                _legendRow(const Color(0xff1E7F3F), 'Safe (0, 80) %'),
                const SizedBox(height: 6),
                _legendRow(const Color(0xffE6C300), 'Warning (80, 100) %'),
                const SizedBox(height: 6),
                _legendRow(const Color(0xffC62828), 'Failed'),
              ],
            ),
          ),

          // ================= RIGHT EMPTY SPACE =================
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _legendRow(Color color, String text) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
