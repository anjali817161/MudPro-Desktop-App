import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class SceView extends StatelessWidget {
  SceView({super.key});
  final c = Get.find<UgController>();

  static const rowH = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [

  // ================= SHAKER =================
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Column(
                children: [
                  _sectionTitle('Shaker'),
                  SingleChildScrollView(
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(color: Colors.black12, width: 1),
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        _tableHeaderRow(['Shaker', 'Model', 'No. of Screen', 'Plot']),
                        ..._shakerBodyRows(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ================= OTHER SCE =================
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Column(
                children: [
                  _sectionTitle('Other SCE'),
                  Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12, width: 1),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                    },
                    children: [
                      _tableHeaderRow(['Type', 'Model 1', 'Model 2', 'Model 3', 'Plot']),
                      ..._otherSceBodyRows(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Container(
      height: rowH,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      color: const Color(0xffE6E6E6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ================= TABLE HEADER =================
  Widget _tableHeader(List<String> headers) {
    return Container(
      height: rowH,
      color: const Color(0xffF2F2F2),
      child: Row(
        children: _addDividers(headers.map((h) => _headerCell(h)).toList()),
      ),
    );
  }

  Widget _headerCell(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ================= SHAKER BODY =================
  Widget _shakerBody() {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (_, i) {
        final hasData = i < c.shakers.length;
        final s = hasData ? c.shakers[i] : null;

        return _row([
          _editableText(hasData ? s!.shaker : ''),
          _editableRx(hasData ? s!.model : RxString('')),
          _editableRx(hasData ? s!.screens : RxString('')),
          _check(hasData ? s!.plot : RxBool(false)),
        ]);
      },
    );
  }

  // ================= OTHER SCE BODY =================
  Widget _otherSceBody() {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (_, i) {
        final hasData = i < c.otherSce.length;
        final o = hasData ? c.otherSce[i] : null;

        return _row([
          _editableText(hasData ? o!.type : ''),
          _editableRx(hasData ? o!.model1 : RxString('')),
          _editableRx(hasData ? o!.model2 : RxString('')),
          _editableRx(hasData ? o!.model3 : RxString('')),
          _check(hasData ? o!.plot : RxBool(false)),
        ]);
      },
    );
  }

  // ================= ROW =================
  Widget _row(List<Widget> cells) {
    return Container(
      height: rowH,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(children: cells),
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

  TableRow _tableHeaderRow(List<String> headers) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
      children: headers.map((h) => Container(
        height: rowH,
        alignment: Alignment.center,
        child: Text(
          h,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      )).toList(),
    );
  }

  List<TableRow> _shakerBodyRows() {
    return List.generate(25, (i) {
      final hasData = i < c.shakers.length;
      final s = hasData ? c.shakers[i] : null;
      return TableRow(
        children: [
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.centerLeft,
            child: Text(
              hasData ? s!.shaker : '',
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: hasData ? Obx(() => c.isLocked.value
                ? Text(s!.model.value, style: const TextStyle(fontSize: 11))
                : TextField(
                    controller: TextEditingController(text: s!.model.value),
                    onChanged: (v) => s!.model.value = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )) : const SizedBox(),
          ),
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: hasData ? Obx(() => c.isLocked.value
                ? Text(s!.screens.value, style: const TextStyle(fontSize: 11))
                : TextField(
                    controller: TextEditingController(text: s!.screens.value),
                    onChanged: (v) => s!.screens.value = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )) : const SizedBox(),
          ),
          Container(
            height: rowH,
            alignment: Alignment.center,
            child: hasData ? Obx(() => Checkbox(
                  value: s!.plot.value,
                  onChanged: c.isLocked.value ? null : (x) => s!.plot.value = x!,
                  visualDensity: VisualDensity.compact,
                )) : const SizedBox(),
          ),
        ],
      );
    });
  }

  List<TableRow> _otherSceBodyRows() {
    return List.generate(12, (i) {
      final hasData = i < c.otherSce.length;
      final o = hasData ? c.otherSce[i] : null;
      return TableRow(
        children: [
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.centerLeft,
            child: Text(
              hasData ? o!.type : '',
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: hasData ? Obx(() => c.isLocked.value
                ? Text(o!.model1.value, style: const TextStyle(fontSize: 11))
                : TextField(
                    controller: TextEditingController(text: o!.model1.value),
                    onChanged: (v) => o!.model1.value = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )) : const SizedBox(),
          ),
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: hasData ? Obx(() => c.isLocked.value
                ? Text(o!.model2.value, style: const TextStyle(fontSize: 11))
                : TextField(
                    controller: TextEditingController(text: o!.model2.value),
                    onChanged: (v) => o!.model2.value = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )) : const SizedBox(),
          ),
          Container(
            height: rowH,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: hasData ? Obx(() => c.isLocked.value
                ? Text(o!.model3.value, style: const TextStyle(fontSize: 11))
                : TextField(
                    controller: TextEditingController(text: o!.model3.value),
                    onChanged: (v) => o!.model3.value = v,
                    style: const TextStyle(fontSize: 11),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )) : const SizedBox(),
          ),
          Container(
            height: rowH,
            alignment: Alignment.center,
            child: hasData ? Obx(() => Checkbox(
                  value: o!.plot.value,
                  onChanged: c.isLocked.value ? null : (x) => o!.plot.value = x!,
                  visualDensity: VisualDensity.compact,
                )) : const SizedBox(),
          ),
        ],
      );
    });
  }

  // ================= CELLS =================
  Widget _editableText(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          value,
          style: const TextStyle(fontSize: 11),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _editableRx(RxString value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Obx(() => c.isLocked.value
            ? Text(value.value, style: const TextStyle(fontSize: 11))
            : TextField(
                controller: TextEditingController(text: value.value),
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

  Widget _check(RxBool v) {
    return SizedBox(
      width: 48,
      child: Obx(() => Checkbox(
            value: v.value,
            onChanged: c.isLocked.value ? null : (x) => v.value = x!,
            visualDensity: VisualDensity.compact,
          )),
    );
  }
}
