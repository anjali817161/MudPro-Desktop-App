import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/model/producst_model.dart';

class InventoryProductsView extends StatelessWidget {
  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // ================= MAIN PRODUCTS TABLE =================
        Expanded(
          flex: 3,
          child: Obx(() => Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Colors.black26),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),
                        1: FixedColumnWidth(260),
                        2: FixedColumnWidth(90),
                        3: FixedColumnWidth(70),
                        4: FixedColumnWidth(90),
                        5: FixedColumnWidth(90),
                        6: FixedColumnWidth(90),
                        7: FixedColumnWidth(140),
                        8: FixedColumnWidth(90),
                        9: FixedColumnWidth(90),
                        10: FixedColumnWidth(70),
                      },
                      children: [
                        _headerRow([
                          '#',
                          'Product',
                          'Code',
                          'SG',
                          'Unit',
                          'Price',
                          'Initial',
                          'Group',
                          'Vol. Add',
                          'Calculate',
                          'Tax',
                        ]),
                        ...c.products.map((p) => _productRow(p)),
                      ],
                    ),
                  ),
                ),
              )),
        ),

        const SizedBox(height: 6),

        // ================= BOTTOM TABLES =================
        Expanded(
          flex: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return Column(
                  children: [
                    Expanded(child: _premixedMudTable()),
                    const SizedBox(height: 6),
                    Expanded(child: _obmTable()),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(flex: 1, child: _premixedMudTable()),
                    const SizedBox(width: 6),
                    Expanded(flex: 1, child: _obmTable()),
                  ],
                );
              }
            },
          ),
        ),

        const SizedBox(height: 6),

      ],
    );
  }

  // ================= PRODUCT ROW =================
  TableRow _productRow(ProductModel p) {
    return TableRow(children: [
      _cell(p.id.toString()),
      _editableCell(p.product, onChanged: (v) {
        p.product = v;
        c.products.refresh();
      }),
      _editableCell(p.code, onChanged: (v) {
        p.code = v;
        c.products.refresh();
      }),
      _editableCell(p.sg, onChanged: (v) {
        p.sg = v;
        c.products.refresh();
      }),
      _editableCell(p.unit, onChanged: (v) {
        p.unit = v;
        c.products.refresh();
      }),
      _editableCell(p.price, onChanged: (v) {
        p.price = v;
        c.products.refresh();
      }),
      _editableCell(p.initial, onChanged: (v) {
        p.initial = v;
        c.products.refresh();
      }),
      _editableCell(p.group, onChanged: (v) {
        p.group = v;
        c.products.refresh();
      }),
      _checkbox(() => p.volAdd, (v) {
        p.volAdd = v;
        c.products.refresh();
      }),
      _checkbox(() => p.calculate, (v) {
        p.calculate = v;
        c.products.refresh();
      }),
      _checkbox(() => p.tax, (v) {
        p.tax = v;
        c.products.refresh();
      }),
    ]);
  }

  // ================= PREMIXED =================
  Widget _premixedMudTable() {
    return Column(
      children: [
        _sectionHeader('Premixed Mud'),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.black26),
              columnWidths: const {
                0: FixedColumnWidth(40),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(90),
                4: FixedColumnWidth(90),
                5: FixedColumnWidth(60),
              },
              children: [
                _headerRow(
                    ['#', 'Description', 'MW', 'Leasing Fee', 'Mud Type', 'Tax']),
                ...c.premixed.map((e) => TableRow(children: [
                      _cell(e.id),
                      _editableCell(e.description, onChanged: (v) {
                        e.description = v;
                        c.premixed.refresh();
                      }),
                      _editableCell(e.mw, onChanged: (v) {
                        e.mw = v;
                        c.premixed.refresh();
                      }),
                      _editableCell(e.leasingFee, onChanged: (v) {
                        e.leasingFee = v;
                        c.premixed.refresh();
                      }),
                      _editableCell(e.mudType, onChanged: (v) {
                        e.mudType = v;
                        c.premixed.refresh();
                      }),
                      _checkbox(() => e.tax, (v) {
                        e.tax = v;
                        c.premixed.refresh();
                      }),
                    ])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================= OBM =================
  Widget _obmTable() {
    return Column(
      children: [
        _sectionHeader('8.0 ppg OBM (70/30) with Bar'),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.black26),
              columnWidths: const {
                0: FixedColumnWidth(40),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(80),
              },
              children: [
                _headerRow(['#', 'Product', 'Code', 'SG', 'Conc']),
                ...c.obm.map((e) => TableRow(children: [
                      _cell(e.id),
                      _editableCell(e.product, onChanged: (v) {
                        e.product = v;
                        c.obm.refresh();
                      }),
                      _editableCell(e.code, onChanged: (v) {
                        e.code = v;
                        c.obm.refresh();
                      }),
                      _editableCell(e.sg, onChanged: (v) {
                        e.sg = v;
                        c.obm.refresh();
                      }),
                      _editableCell(e.conc, onChanged: (v) {
                        e.conc = v;
                        c.obm.refresh();
                      }),
                    ])),
              ],
            ),
          ),
        ),
      ],
    );
  }

 

  // ================= HELPERS =================
  TableRow _headerRow(List<String> h) => TableRow(
        decoration: const BoxDecoration(color: Color(0xffEFEFEF)),
        children: h.map((e) => _cell(e, bold: true)).toList(),
      );

  Widget _cell(String v, {bool bold = false}) => Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          v,
          style: TextStyle(
              fontSize: 10, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
        ),
      );

  Widget _editableCell(String value, {Function(String)? onChanged}) => Padding(
        padding: const EdgeInsets.all(4),
        child: Obx(() => c.isLocked.value
            ? Text(value, style: const TextStyle(fontSize: 10))
            : TextFormField(
                initialValue: value,
                onChanged: onChanged,
                style: const TextStyle(fontSize: 10),
                decoration:
                    const InputDecoration(isDense: true, border: InputBorder.none),
              )),
      );

  Widget _checkbox(bool Function() getter, Function(bool) onChange) {
    return Obx(() => Checkbox(
          value: getter(),
          onChanged: c.isLocked.value ? null : (v) => onChange(v!),
          visualDensity: VisualDensity.compact,
        ));
  }

  Widget _sectionHeader(String t) => Container(
        height: 28,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        color: const Color(0xffE6E6E6),
        child:
            Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      );

  Widget _footerInput(String label) => SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10)),
            Obx(() => TextField(
                  enabled: !c.isLocked.value,
                  decoration: const InputDecoration(isDense: true),
                )),
          ],
        ),
      );

  Widget _checkboxText(String t) => Row(
        children: [
          Obx(() => Checkbox(
                value: false,
                onChanged: c.isLocked.value ? null : (_) {},
                visualDensity: VisualDensity.compact,
              )),
          Text(t, style: const TextStyle(fontSize: 10)),
        ],
      );
}
