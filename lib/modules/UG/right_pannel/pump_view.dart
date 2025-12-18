import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class PumpView extends StatelessWidget {
  PumpView({super.key});
  final c = Get.find<UgController>();

  static const rowH = 28.0;

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
            _headerRow(),
            Expanded(child: _tableBody()),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
 Widget _headerRow() {
  return Column(
    children: [
      Container(
        height: 35,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2), // 👈 subtle highlight
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 1), // 👈 divider
          ),
        ),
        child: Row(
          children: _addDividers([
            const _HCell('#', flex: 1),
            const _HCell('Type', flex: 2),
            const _HCell('Model', flex: 3),
            const _HCell('Liner ID\n(in)', flex: 2),
            const _HCell('Rod OD\n(in)', flex: 2),
            const _HCell('Stk. Length\n(in)', flex: 2),
            const _HCell('Efficiency\n(%)', flex: 2),
            const _HCell('Disp.\n(bbl/stk)', flex: 2),
            const _HCell('Max. Pump P.\n(psi)', flex: 2),
            const _HCell('Max. HP\n(HP)', flex: 2),
            const _HCell('Surface Line\nLength (m)', flex: 2),
            const _HCell('ID (in)', flex: 2),
          ]),
        ),
      ),

      // 👇 EXTRA STRONG DIVIDER (like desktop software)
      const Divider(
        height: 1,
        thickness: 1,
        color: Colors.black38,
      ),
    ],
  );
}


  // ================= BODY =================
  Widget _tableBody() {
    return ListView.builder(
      itemCount: 12, // extra empty rows
      itemBuilder: (_, i) {
        final hasData = i < c.pumps.length;
        final p = hasData ? c.pumps[i] : null;

        return Container(
          height: rowH,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          child: Row(
            children: _addDividers([
              _cellText('${i + 1}', flex: 1),
              _editable(p?.type, flex: 2),
              _editable(p?.model, flex: 3),
              _editable(p?.linerId, flex: 2),
              _editable(p?.rodOd, flex: 2),
              _editable(p?.strokeLength, flex: 2),
              _editable(p?.efficiency, flex: 2),
              _editable(p?.displacement, flex: 2),
              _editable(p?.maxPumpP, flex: 2),
              _editable(p?.maxHp, flex: 2),
              _editable(p?.surfaceLen, flex: 2),
              _editable(p?.surfaceId, flex: 2),
            ]),
          ),
        );
      },
    );
  }

  // ================= HELPER =================
  List<Widget> _addDividers(List<Widget> widgets) {
    final List<Widget> result = [];
    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i < widgets.length - 1) {
        result.add(const VerticalDivider(width: 1, color: Colors.black12));
      }
    }
    return result;
  }

  // ================= CELLS =================
  Widget _cellText(String t, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          t,
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }

  Widget _editable(RxString? value, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Obx(() => c.isLocked.value || value == null
            ? Text(value?.value ?? '', style: const TextStyle(fontSize: 11))
            : TextField(
                controller:
                    TextEditingController(text: value.value),
                onChanged: (v) => value.value = v,
                style: const TextStyle(fontSize: 11),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              )),
      ),
    );
  }

  Widget _dropdown(
    RxString? value,
    List<String> items,
    Function(String) onChanged, {
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Obx(() => c.isLocked.value || value == null
            ? Text(value?.value ?? '', style: const TextStyle(fontSize: 11))
            : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value.value.isEmpty ? null : value.value,
                  items: items
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => onChanged(v!),
                  isDense: true,
                ),
              )),
      ),
    );
  }
}

// ================= HEADER CELL =================
class _HCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
