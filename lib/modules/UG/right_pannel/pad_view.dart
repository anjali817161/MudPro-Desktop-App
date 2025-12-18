import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class PadView extends StatelessWidget {
  PadView({super.key});

  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= LEFT TABLE =================
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.black26),
                columnWidths: const {
                  0: FixedColumnWidth(200),
                },
                children: [

                  // LOCATION (RADIO BUTTONS ROW)
                  TableRow(children: [
                    _labelCell('Location'),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Obx(() => Row(
                            children: [
                              _radio('Land'),
                              const SizedBox(width: 16),
                              _radio('Offshore'),
                            ],
                          )),
                    ),
                  ]),

                  _row('Field/Block', 'Umm Gudair (UG)'),
                  _row('Rig', 'SP-175'),
                  _row('County/Parish/Offshore Area', 'Kuwait'),
                  _row('State/Province', 'West Kuwait'),
                  _row('Country', 'Kuwait'),
                  _row('Stock Point', 'Burgan'),
                  _row('Operator', 'Kuwait Oil Company'),
                  _row('Operator Rep.', 'Chandra Shekhar'),
                  _row('Contractor', 'Sinopec'),
                  _row('Contractor Rep.', 'Yin'),
                  _row('Air Gap', ''),
                  _row('Water Depth', ''),
                  _row('Riser OD', ''),
                  _row('Riser ID', ''),
                  _row('Choke Line ID', ''),
                  _row('Kill Line ID', ''),
                  _row('Boost Line ID', ''),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ================= RIGHT SIDE =================
          Expanded(
            flex: 2,
            child: Column(
              children: [

                // LOGO BOX
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: const Center(
                    child: Text(
                      'Kuwait Oil Company\nLOGO',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // MEMO BOX
                Expanded(
                  child: Container(
                    height: 120,
                    width: 600,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Obx(() => TextField(
                          enabled: !c.isLocked.value,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Memo',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 11),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

  TableRow _row(String label, String value) {
    return TableRow(children: [
      _labelCell(label),
      _valueCell(value),
    ]);
  }

  Widget _labelCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _valueCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(() => c.isLocked.value
          ? Text(value, style: const TextStyle(fontSize: 11))
          : TextFormField(
              initialValue: value,
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            )),
    );
  }

  Widget _radio(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: text,
          groupValue: c.location.value,
          onChanged: c.isLocked.value ? null : (v) => c.location.value = v!,
          visualDensity: VisualDensity.compact,
        ),
        Text(text, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
