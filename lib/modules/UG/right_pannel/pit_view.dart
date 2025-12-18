import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class PitView extends StatelessWidget {
  PitView({super.key});

  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
        ),
        child: Column(
          children: [
            _header(),
            Expanded(child: _table()),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Container(
      height: 28,
      color: const Color(0xffE6E6E6),
      child: Row(
        children: const [
          _HeaderCell('#', 40),
          _HeaderCell('Pit', 220),
          _HeaderCell('Capacity (bbl)', 120),
          _HeaderCell('Initial Active', 120),
        ],
      ),
    );
  }

  // ================= TABLE =================
  Widget _table() {
    return Obx(() => ListView.builder(
          itemCount: c.pits.length,
          itemBuilder: (context, index) {
            final p = c.pits[index];
            return Container(
              height: 26,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Row(
                children: [
                  _cell(p.id.toString(), 40),
                  _cell(p.pit, 220),
                  _capacityCell(p.capacity, 120),
                  _activeCell(p),
                ],
              ),
            );
          },
        ));
  }

  // ================= CELLS =================
  Widget _cell(String text, double width) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }

  Widget _capacityCell(String value, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
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

  Widget _activeCell(p) {
    return SizedBox(
      width: 120,
      child: Obx(() => Checkbox(
            value: p.active.value,
            onChanged: c.isLocked.value
                ? null
                : (v) => p.active.value = v!,
            visualDensity: VisualDensity.compact,
          )),
    );
  }
}

// ================= HEADER CELL =================
class _HeaderCell extends StatelessWidget {
  final String text;
  final double width;

  const _HeaderCell(this.text, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
