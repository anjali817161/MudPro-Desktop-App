import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import '../../controller/pump_controller.dart';

class PumpPage extends StatelessWidget {
  PumpPage({super.key});
  final PumpController controller = Get.put(PumpController());
  final dashboard = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        
        if (width < 800) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _header(),
                    const SizedBox(height: 12),
                    _pumpTable(),
                    const SizedBox(height: 12),
                    _summaryBox(),
                    const SizedBox(height: 12),
                    _shakerTable(),
                    const SizedBox(height: 12),
                    _otherSCETable(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT PORTION - Pump Table
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _pumpTable(),
                          const SizedBox(height: 12),
                          _shakerTable(),
                          const SizedBox(height: 12),
                          _otherSCETable(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT PORTION - Summary Box
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 300, maxWidth: 350),
                      child: _summaryBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header with primary color
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.precision_manufacturing, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Pump & Equipment Configuration",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PUMP TABLE =================
  Widget _pumpTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with primary color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.settings, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      "Pump Configuration",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Table
          Obx(() => Container(
            constraints: const BoxConstraints(maxHeight: 250),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(80),
                      2: FixedColumnWidth(90),
                      3: FixedColumnWidth(90),
                      4: FixedColumnWidth(100),
                      5: FixedColumnWidth(100),
                      6: FixedColumnWidth(90),
                    },
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                        ),
                        children: [
                          _buildTableHeaderCell("Model", TextAlign.left),
                          _buildTableHeaderCell("Type", TextAlign.center),
                          _buildTableHeaderCell("Liner ID\n(in)", TextAlign.center),
                          _buildTableHeaderCell("Rod OD\n(in)", TextAlign.center),
                          _buildTableHeaderCell("Stroke Length\n(in)", TextAlign.center),
                          _buildTableHeaderCell("Efficiency\n(%)", TextAlign.center),
                          _buildTableHeaderCell("Rate\n(gpm)", TextAlign.center),
                        ],
                      ),
                      
                      // Data rows
                      ...controller.pumpRows.map((row) {
                        return _buildPumpDataRow([
                          row["model"]!,
                          row["type"]!,
                          "${row["liner"]}",
                          "-",
                          "${row["stroke"]}",
                          "${row["eff"]}%",
                          "0.0",
                        ]);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ================= SUMMARY BOX =================
  Widget _summaryBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with primary color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.summarize, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildSummaryRow("Pump Rate", "0.0", "gpm"),
                const SizedBox(height: 2),
                _buildSummaryRow("Pump Pressure", "0", "psi"),
                const SizedBox(height: 2),
                _buildSummaryRow("Boost Pump Rate", "0", "gpm"),
                const SizedBox(height: 2),
                _buildSummaryRow("Return Rate", "0", "gpm"),
                const SizedBox(height: 2),
                _buildSummaryRow("DH Tools P. Loss", "0", "psi"),
                const SizedBox(height: 2),
                _buildSummaryRow("Motor P. Loss", "0", "psi"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= SHAKER TABLE =================
  Widget _shakerTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with primary color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.filter_alt, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Shaker Configuration",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Table
          Obx(() => Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(120),
                      2: FixedColumnWidth(120),
                    },
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                        ),
                        children: [
                          _buildTableHeaderCell("Shaker", TextAlign.left),
                          _buildTableHeaderCell("Model", TextAlign.center),
                          _buildTableHeaderCell("Screen Mesh", TextAlign.center),
                        ],
                      ),
                      
                      // Data rows
                      ...controller.shakerRows.map((row) {
                        return _buildPumpDataRow([
                          row["shaker"]!,
                          row["model"]!,
                          "100 / 80 / 200",
                        ]);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ================= OTHER SCE TABLE =================
  Widget _otherSCETable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with primary color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Other SCE Equipment",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Table
          Obx(() => Container(
            constraints: const BoxConstraints(maxHeight: 250),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(120),
                      2: FixedColumnWidth(100),
                      3: FixedColumnWidth(100),
                    },
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                        ),
                        children: [
                          _buildTableHeaderCell("SCE", TextAlign.left),
                          _buildTableHeaderCell("Model", TextAlign.center),
                          _buildTableHeaderCell("Time\n(hr)", TextAlign.center),
                          _buildTableHeaderCell("OOC Wt\n(%)", TextAlign.center),
                        ],
                      ),
                      
                      // Data rows
                      ...controller.sceRows.map((row) {
                        return _buildSCEDataRow([
                          row["sce"]!,
                          row["model"]!,
                          "",
                          "",
                        ]);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ================= HELPER METHODS =================
  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.primaryColor,
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildPumpDataRow(List<String> values) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
        color: Colors.white,
      ),
      children: values.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        bool isDropdown = false;
        if (values.length == 7) { // Pump table
          isDropdown = index == 0 || index == 1;
        } else if (values.length == 3) { // Shaker table
          isDropdown = index == 0;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40,
          child: dashboard.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                )
              : isDropdown
                  ? _buildEditableDropdownCell(value, _getDropdownOptions(index, values.length))
                  : TextFormField(
                      initialValue: value,
                      style: TextStyle(fontSize: 11),
                      textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.primaryColor, width: 1),
                        ),
                      ),
                    ),
        );
      }).toList(),
    );
  }

  TableRow _buildSCEDataRow(List<String> values) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
        color: Colors.white,
      ),
      children: values.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        bool isDropdown = false;
        if (values.length == 4) { // SCE table
          isDropdown = index == 0;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40,
          child: dashboard.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                )
              : isDropdown
                  ? _buildEditableDropdownCell(value, _getDropdownOptions(index, values.length))
                  : TextFormField(
                      initialValue: value,
                      style: TextStyle(fontSize: 11),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.primaryColor, width: 1),
                        ),
                      ),
                    ),
        );
      }).toList(),
    );
  }

  Widget _buildEditableDropdownCell(String value, List<String> options) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        isDense: true,
        iconSize: 14,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        items: options.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 11)),
          );
        }).toList(),
        onChanged: dashboard.isLocked.value ? null : (v) {},
      ),
    );
  }

  List<String> _getDropdownOptions(int index, int valuesLength) {
    if (valuesLength == 7) { // Pump table
      if (index == 0) return controller.pumpModels;
      if (index == 1) return ["Triplex", "Duplex", "Centrifugal", "Reciprocating"];
    } else if (valuesLength == 3) { // Shaker table
      if (index == 0) return controller.shakerTypes;
    } else if (valuesLength == 4) { // SCE table
      if (index == 0) return controller.sceTypes;
    }
    return [];
  }

  Widget _buildSummaryRow(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: dashboard.isLocked.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "$value $unit",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: value,
                            style: TextStyle(fontSize: 11),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.primaryColor, width: 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}