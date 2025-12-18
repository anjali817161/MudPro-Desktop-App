import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_products_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_products_view.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_service.dart';

class InventoryView extends StatelessWidget {
  InventoryView({super.key});
  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // ================= TOP SUB TABS =================
        Container(
          height: 34,
          color: const Color(0xffE6E6E6),
          child: Row(
            children: [
              _tabButton('Products'),
              _tabButton('Services'),
            ],
          ),
        ),

        // ================= MIDDLE CONTENT =================
        Expanded(
          child: Obx(() {
            return c.inventoryTab.value == 'Products'
                ? InventoryProductsView()
                : InventoryServicesView();
          }),
        ),

        // ================= FIXED BOTTOM FOOTER =================
        _inventoryFooter(),
      ],
    );
  }

  // ---------------- TAB BUTTON ----------------
  Widget _tabButton(String title) {
    return Obx(() {
      final active = c.inventoryTab.value == title;
      return InkWell(
        onTap: () => c.inventoryTab.value = title,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }

  // ================= FIXED FOOTER =================
 Widget _inventoryFooter() {
  final c = Get.find<UgController>();

  return Container(
    height: 160,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: const BoxDecoration(
      color: Color(0xffF2F2F2),
      border: Border(top: BorderSide(color: Colors.black26)),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Small screens: Stack vertically
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ================= LEFT : FEES =================
                Column(
                  children: [
                    _footerRow(
                      'Bulk Tank Setup Fee (\$)',
                      enabled: !c.isLocked.value,
                    ),
                    const SizedBox(height: 6),
                    _footerRow(
                      'Tax Rate (%)',
                      enabled: !c.isLocked.value,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ================= MIDDLE : APPLY CHANGED PRICES =================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    color: const Color(0xffF7F7F7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Apply Changed Prices',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      _radioRow('To All'),
                      _radioRow('From Now On'),
                      Row(
                        children: [
                          _radioRow('From'),
                          const SizedBox(width: 6),
                          Expanded(
                            child: SizedBox(
                              height: 24,
                              child: Obx(() => TextField(
                                controller: TextEditingController(text: c.fromDate.value),
                                enabled: !c.isLocked.value,
                                onChanged: (value) => c.fromDate.value = value,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                ),
                                style: const TextStyle(fontSize: 10),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ================= RIGHT : INVENTORY PICKUP =================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Inventory Pickup',
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 28,
                      child: Obx(() => ElevatedButton(
                        onPressed: c.isLocked.value ? null : () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(fontSize: 11),
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Large screens: Row layout with flexible widths
          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= LEFT : FEES =================
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _footerRow(
                        'Bulk Tank Setup Fee (\$)',
                        enabled: !c.isLocked.value,
                      ),
                      const SizedBox(height: 6),
                      _footerRow(
                        'Tax Rate (%)',
                        enabled: !c.isLocked.value,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // ================= MIDDLE : APPLY CHANGED PRICES =================
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: const Color(0xffF7F7F7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Apply Changed Prices',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        _radioRow('To All'),
                        _radioRow('From Now On'),
                        Row(
                          children: [
                            _radioRow('From'),
                            const SizedBox(width: 6),
                            Expanded(
                              child: SizedBox(
                                height: 24,
                                child: Obx(() => TextField(
                                  controller: TextEditingController(text: c.fromDate.value),
                                  enabled: !c.isLocked.value,
                                  onChanged: (value) => c.fromDate.value = value,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  ),
                                  style: const TextStyle(fontSize: 10),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // ================= RIGHT : INVENTORY PICKUP =================
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Inventory Pickup',
                        style: TextStyle(fontSize: 11),
                      ),
                      const SizedBox(height: 90),
                      SizedBox(
                        height: 28,
                        child: Obx(() => ElevatedButton(
                          onPressed: c.isLocked.value ? null : () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(fontSize: 11),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    ),
  );
}


Widget _footerRow(String label, {required bool enabled}) {
  final c = Get.find<UgController>();
  return Row(
    children: [
      SizedBox(
        width: 150,
        child: Text(label, style: const TextStyle(fontSize: 11)),
      ),
      SizedBox(
        width: 90,
        height: 24,
        child: Obx(() => TextField(
          controller: TextEditingController(
            text: label.contains('Bulk Tank') ? c.bulkTankSetupFee.value : c.taxRate.value,
          ),
          enabled: enabled,
          onChanged: (value) {
            if (label.contains('Bulk Tank')) {
              c.bulkTankSetupFee.value = value;
            } else {
              c.taxRate.value = value;
            }
          },
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          ),
          style: const TextStyle(fontSize: 10),
        )),
      ),
    ],
  );
}

Widget _radioRow(String text) {
  final c = Get.find<UgController>();

  return Row(
    children: [
      Obx(() => Radio<String>(
            value: text,
            groupValue: c.applyChangedPricesOption.value,
            onChanged: c.isLocked.value ? null : (value) => c.applyChangedPricesOption.value = value!,
            visualDensity: VisualDensity.compact,
          )),
      Text(text, style: const TextStyle(fontSize: 10)),
    ],
  );
}




}
