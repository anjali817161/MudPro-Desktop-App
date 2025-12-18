import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/controller/UG_ST_controller.dart';

class WellView extends StatelessWidget {
  WellView({super.key});
  final c = Get.find<UgStController>();

  static const double rowH = 28;

  Widget _row(String label, String value) {
    return Container(
      height: rowH,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [

          // ---------- LABEL ----------
          Container(
            width: 280,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11),
            ),
          ),

          // ---------- VALUE WITH VERTICAL BORDERS ----------
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black26),
                  right: BorderSide(color: Colors.black26),
                ),
              ),
              child: Obx(() => c.isLocked.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 11),
                      ),
                    )
                  : TextFormField(
                      initialValue: value,
                      style: const TextStyle(fontSize: 11),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 6),
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= TOP WELL TABLE =================
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 700, // ✅ NOT FULL WIDTH (image style)
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                child: Column(
                  children: [
                    _row("Well Name/No.", "UG-0293 ST"),
                    _row("API Well No.", ""),
                    _row("Spud Date", "11/26/2025"),
                    _row("Section/Township/Range", "UMM Gudair (UG)"),
                    _row("Longitude", "3197265.560"),
                    _row("Latitude", "768061.45"),
                    _row("KOP", "2377.44 (m)"),
                    _row("LP", ""),
                    _row("Bulk Tank Setup Fee", "(\$)"),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ================= MEMO =================
          const Text(
            "Memo",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),

          Align(
            alignment: Alignment.centerLeft,
            child: Obx(() => Container(
                  height: 220,
                  width: 700,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: c.isLocked.value
                      ? const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 11),
                          ),
                        )
                      : TextFormField(
                          maxLines: null,
                          expands: true,
                          style: const TextStyle(fontSize: 11),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6),
                          ),
                        ),
                )),
          ),
        ],
      ),
    );
  }
}
