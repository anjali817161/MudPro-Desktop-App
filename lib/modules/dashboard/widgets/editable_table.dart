import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';

class EditableTable extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Description")),
              DataColumn(label: Text("MD")),
              DataColumn(label: Text("TVD")),
              DataColumn(label: Text("Inc")),
            ],
            rows: List.generate(6, (index) {
              return DataRow(cells: [
                _cell("Casing ${index + 1}", c.isLocked.value),
                _cell("9055", c.isLocked.value),
                _cell("8630", c.isLocked.value),
                _cell("73.45", c.isLocked.value),
              ]);
            }),
          ),
        ));
  }

  DataCell _cell(String value, bool locked) {
    return DataCell(
      locked
          ? Text(value)
          : TextFormField(
              initialValue: value,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            ),
    );
  }
}
