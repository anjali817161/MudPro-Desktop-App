import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/model/producst_model.dart';

class InventoryServicesView extends StatelessWidget {
  InventoryServicesView({super.key});
  final c = Get.find<UgController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= LEFT COLUMN =================
          Expanded(
            flex: 2,
            child: Column(
              children: [

                // -------- PACKAGES --------
                _sectionHeader('Package'),
                Expanded(child: _packagesTable()),

                const SizedBox(height: 8),

                // -------- ENGINEERING --------
                _sectionHeader('Engineering'),
                Expanded(child: _engineeringTable()),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ================= RIGHT COLUMN =================
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _sectionHeader('Services'),
                Expanded(child: _servicesTable()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================================================
  // ================= TABLES ==========================
  // ===================================================

 Widget _packagesTable() {
  final rows = c.packages.map((p) => [
        p.id,
        p.package,
        p.code,
        p.unit,
        p.price,
        p.initial,
        p.tax,
      ]).toList();

  return SizedBox(
    height: 260, // 🔒 FIXED HEIGHT (as image)
    child: SingleChildScrollView(
      child: Table(
        border: TableBorder.all(color: Colors.black26),
        columnWidths: const {
          0: FixedColumnWidth(40),
        },
        children: [
          _headerRow(['#', 'Package', 'Code', 'Unit', 'Price (\$)', 'Initial', 'Tax']),

          // DATA ROWS OR EMPTY SPACE
          if (rows.isNotEmpty)
            ...rows.map((row) => _tableRow(row, onChangedList: [
              null,
              (v) => row[1] = v,
              (v) => row[2] = v,
              (v) => row[3] = v,
              (v) => row[4] = v,
              (v) => row[5] = v,
            ], onCheckboxChangedList: [
              null,
              null,
              null,
              null,
              null,
              null,
              (v) => row[6] = v,
            ]))
          else
            ..._emptyRows(7, 8), // 👈 empty rows
        ],
      ),
    ),
  );
}


  Widget _engineeringTable() {
    return _table(
      headers: ['#', 'Engineering', 'Code', 'Unit', 'Price (\$)', 'Tax'],
      rows: c.engineering.map((e) => [
        e.id,
        e.name,
        e.code,
        e.unit,
        e.price,
        e.tax,
      ]).toList(),
      models: c.engineering,
      checkboxCols: [5],
    );
  }

  Widget _servicesTable() {
  return _table(
    headers: ['#', 'Services', 'Code', 'Unit', 'Price (\$)', 'Tax'],
    rows: c.services.map((s) => [
      s.id,
      s.service,
      s.code,
      s.unit,
      s.price,
      s.tax,
    ]).toList(),
    models: c.services,
    checkboxCols: [5],
  );
}

TableRow _headerRow(List<String> headers) {
  return TableRow(
    decoration: const BoxDecoration(
      color: Color(0xffE6E6E6), // MudPro header grey
    ),
    children: headers.map((h) {
      return Container(
        height: 28,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black26),
            bottom: BorderSide(color: Colors.black26),
          ),
        ),
        child: Text(
          h,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList(),
  );
}



TableRow _tableRow(List<dynamic> values, {List<Function(String)?>? onChangedList, List<Function(bool)?>? onCheckboxChangedList}) {
  return TableRow(
    children: List.generate(values.length, (i) {
      if (values[i] is bool) {
        return _checkboxCell(values[i], onChanged: onCheckboxChangedList?[i]);
      }
      return _editableCell(values[i].toString(), onChanged: onChangedList?[i]);
    }),
  );
}




  List<TableRow> _emptyRows(int columns, int count) {
  return List.generate(
    count,
    (_) => TableRow(
      children: List.generate(
        columns,
        (_) => Container(
          height: 26,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ),
    ),
  );
}


  // ===================================================
  // ================= COMMON TABLE ====================
  // ===================================================

  Widget _table({
    required List<String> headers,
    required List<List<dynamic>> rows,
    required List<dynamic> models,
    List<int> checkboxCols = const [],
  }) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(color: Colors.black26),
        columnWidths: const {
          0: FixedColumnWidth(40),
        },
        children: [
          // HEADER
          TableRow(
            decoration: const BoxDecoration(color: Color(0xffEFEFEF)),
            children: headers
                .map((h) => _cell(h, bold: true))
                .toList(),
          ),

          // ROWS
          ...rows.asMap().entries.map((entry) {
            final rowIndex = entry.key;
            final row = entry.value;
            final model = models[rowIndex];
            return TableRow(
              children: List.generate(row.length, (i) {
                if (checkboxCols.contains(i)) {
                  return _checkboxCell(row[i], onChanged: (v) {
                    if (model is EngineeringModel) {
                      model.tax = v;
                      c.engineering.refresh();
                    } else if (model is ServiceModel) {
                      model.tax = v;
                      c.services.refresh();
                    } else if (model is PackageModel) {
                      model.tax = v;
                      c.packages.refresh();
                    }
                  });
                }
                return _editableCell(row[i].toString(), onChanged: (v) {
                  if (model is EngineeringModel) {
                    if (i == 1) model.name = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    c.engineering.refresh();
                  } else if (model is ServiceModel) {
                    if (i == 1) model.service = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    c.services.refresh();
                  } else if (model is PackageModel) {
                    if (i == 1) model.package = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    if (i == 5) model.initial = v;
                    c.packages.refresh();
                  }
                });
              }),
            );
          }),
        ],
      ),
    );
  }

  // ===================================================
  // ================= CELLS ===========================
  // ===================================================

  Widget _cell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _editableCell(String value, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(() => c.isLocked.value
          ? Text(value, style: const TextStyle(fontSize: 10))
          : TextFormField(
              initialValue: value,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 10),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            )),
    );
  }

  Widget _checkboxCell(bool value, {Function(bool)? onChanged}) {
    return Center(
      child: Obx(() => Checkbox(
            value: value,
            onChanged: c.isLocked.value ? null : (v) => onChanged?.call(v!),
            visualDensity: VisualDensity.compact,
          )),
    );
  }

  Widget _sectionHeader(String text) {
    return Container(
      height: 26,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      color: const Color(0xffE6E6E6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
