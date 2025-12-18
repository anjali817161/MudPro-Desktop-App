import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';

class LeftReportTree extends StatelessWidget {
  LeftReportTree({super.key});

  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      color: const Color(0xffE6E6E6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───── UG HEADER ─────
          _clickableHeader(
            icon: Icons.account_tree,
            text: 'UG',
            id: 'UG',
          ),

          _clickableHeader(
            icon: Icons.location_on,
            text: 'UG-0293 ST',
            id: 'UG-0293-ST',
            indent: 20,
          ),

          const Divider(height: 1),

          // ───── TREE REPORTS ─────
          Expanded(
            child: Obx(() => ListView(
                  padding: EdgeInsets.zero,
                  children: c.reportsTree.map(_buildDateNode).toList(),
                )),
          ),

          // ───── FOOTER NOTE ─────
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12)),
            ),
            child: const Text(
              "* New report is only for active well.",
              style: TextStyle(fontSize: 9, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _clickableHeader({
    required IconData icon,
    required String text,
    required String id,
    double indent = 0,
  }) {
    return Obx(() {
      final selected = c.selectedNodeId.value == id;
      return InkWell(
        onTap: () => c.navigate(id),
        child: Container(
          padding: EdgeInsets.fromLTRB(10 + indent, 8, 8, 8),
          color: selected ? const Color(0xffCFE0F7) : Colors.transparent,
          child: Row(
            children: [
              Icon(icon, size: 14),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // ================= DATE NODE =================
  Widget _buildDateNode(ReportDate dateNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => c.navigate(dateNode.date),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Icon(
                  dateNode.expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  dateNode.date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (dateNode.expanded)
          ...dateNode.items.map(
            (item) => Obx(() {
              final id = '${dateNode.date}-$item';
              final selected = c.selectedNodeId.value == id;

              return InkWell(
                onTap: () => c.navigate(id),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                  color:
                      selected ? const Color(0xffD6E4F5) : Colors.transparent,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }
}
