import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';

class WellTabContent extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        if (width < 800) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    LeftPortion(),
                    const SizedBox(height: 12),
                    MiddlePortion(),
                    const SizedBox(height: 12),
                    RightPortion(),
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
                    // LEFT PORTION - General section
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 300, maxWidth: 350),
                      child: LeftPortion(),
                    ),
                    const SizedBox(width: 12),
                    // MIDDLE PORTION - Cased Hole, Open Hole, Drill String (more width)
                    Expanded(
                      flex: 3,
                      child: MiddlePortion(),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT PORTION - Bit, Nozzle, Time Distribution (less width)
                    Expanded(
                      flex: 2,
                      child: RightPortion(),
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
}

// ==================== LEFT PORTION ====================
class LeftPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralSection(),
      ],
    );
  }
}

// ==================== GENERAL SECTION ====================
class GeneralSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with teal color
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "General Information",
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
          
          // Vertical list of label-value pairs
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildVerticalRow("Report #", "12"),
                SizedBox(height: 2),
                _buildVerticalRow("User Report #", ""),
                SizedBox(height: 2),
                _buildVerticalRow("Date", "12/27/2025"),
                SizedBox(height: 2),
                _buildVerticalRow("Time", "23:30"),
                SizedBox(height: 2),
                _buildVerticalRow("Engineer", "Keyur Agarwal"),
                SizedBox(height: 2),
                _buildVerticalRow("Bit #", "120.0 (°F)"),
                SizedBox(height: 2),
                _buildVerticalRow("Engineer 2", ""),
                SizedBox(height: 2),
                _buildVerticalRow("Bottom T.", "180.0 (°F)"),
                SizedBox(height: 2),
                _buildVerticalRow("Operator Rep.", "Chandra Shekhar"),
                SizedBox(height: 2),
                _buildVerticalRow("Contractor Rep.", "Wang"),
                SizedBox(height: 2),
                _buildVerticalRow("Activity", "Drilling Cement"),
                SizedBox(height: 2),
                _buildVerticalRow("MD", "9055.0 (ft)"),
                SizedBox(height: 2),
                _buildVerticalRow("TVD", "8603.0 (ft)"),
                SizedBox(height: 2),
                _buildVerticalRow("Inc", "73.45 (°)"),
                SizedBox(height: 2),
                _buildVerticalRow("Azi", "206.00 (°)"),
                SizedBox(height: 2),
                _buildVerticalRow("WOB", "10000 (lbf)"),
                SizedBox(height: 2),
                _buildVerticalRow("Rot. Wt.", "(lbf)"),
                SizedBox(height: 2),
                _buildVerticalRow("S/O Wt.", "(lbf)"),
                SizedBox(height: 2),
                _buildVerticalRow("P/U Wt.", "(lbf)"),
                SizedBox(height: 2),
                _buildVerticalRow("RPM", "70.0 (rpm)"),
                SizedBox(height: 2),
                _buildVerticalRow("ROP", "30 (ft/hr)"),
                SizedBox(height: 2),
                _buildVerticalRow("Off-bottom TQ", "4000 (ft-lb)"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalRow(String label, String value) {
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
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff2c3e50),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Obx(() => c.isLocked.value
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  : Container(
                      child: TextFormField(
                        initialValue: value,
                        style: TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                          ),
                        ),
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== MIDDLE PORTION ====================
class MiddlePortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CasedHoleSection(),
        const SizedBox(height: 12),
        OpenHoleSection(),
        const SizedBox(height: 12),
        DrillStringSection(),
      ],
    );
  }
}

// ==================== CASED HOLE SECTION ====================
class CasedHoleSection extends StatelessWidget {
  final c = Get.find<DashboardController>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController odController = TextEditingController();
  final TextEditingController wtController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController topController = TextEditingController();
  final TextEditingController shoeController = TextEditingController();
  final TextEditingController lenController = TextEditingController();

  void _showAddCasingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Casing", style: TextStyle(fontSize: 16)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogTextField(descriptionController, "Description"),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildDialogTextField(odController, "OD (in)")),
                    SizedBox(width: 8),
                    Expanded(child: _buildDialogTextField(wtController, "Wt. (lb/ft)")),
                    SizedBox(width: 8),
                    Expanded(child: _buildDialogTextField(idController, "ID (in)")),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildDialogTextField(topController, "Top (ft)")),
                    SizedBox(width: 8),
                    Expanded(child: _buildDialogTextField(shoeController, "Shoe (ft)")),
                    SizedBox(width: 8),
                    Expanded(child: _buildDialogTextField(lenController, "Len. (ft)")),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _clearControllers();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addCasingToTable();
                Navigator.pop(context);
                _clearControllers();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff0d9488),
              ),
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  void _addCasingToTable() {
    final newCasing = [
      descriptionController.text.isNotEmpty ? descriptionController.text : '-',
      odController.text.isNotEmpty ? odController.text : '-',
      wtController.text.isNotEmpty ? wtController.text : '-',
      idController.text.isNotEmpty ? idController.text : '-',
      topController.text.isNotEmpty ? topController.text : '-',
      shoeController.text.isNotEmpty ? shoeController.text : '-',
      lenController.text.isNotEmpty ? lenController.text : '-',
    ];
    
    // Add to controller or directly to UI (you'll need to implement state management)
    print("Added new casing: $newCasing");
    // Here you should add the new casing to your data source
  }

  void _clearControllers() {
    descriptionController.clear();
    odController.clear();
    wtController.clear();
    idController.clear();
    topController.clear();
    shoeController.clear();
    lenController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Cased Hole",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAddCasingDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 14, color: Color(0xff0d9488)),
                      SizedBox(width: 4),
                      Text(
                        "Add Casing",
                        style: TextStyle(fontSize: 11, color: Color(0xff0d9488)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Table with increased size
          Obx(() => Container(
            constraints: BoxConstraints(maxHeight: 250),
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
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(80),
                      3: FixedColumnWidth(70),
                      4: FixedColumnWidth(80),
                      5: FixedColumnWidth(80),
                      6: FixedColumnWidth(80),
                    },
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xfff0f9ff),
                        ),
                        children: [
                          _buildTableHeaderCell("Description", TextAlign.left),
                          _buildTableHeaderCell("OD\n(in)", TextAlign.center),
                          _buildTableHeaderCell("Wt.\n(lb/ft)", TextAlign.center),
                          _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                          _buildTableHeaderCell("Top\n(ft)", TextAlign.center),
                          _buildTableHeaderCell("Shoe\n(ft)", TextAlign.center),
                          _buildTableHeaderCell("Len.\n(ft)", TextAlign.center),
                        ],
                      ),
                      
                      // Data rows
                      _buildCasingDataRow(['9 5/8" Casing', "9.625", "47.000", "8.681", "0.0", "7830.0", "7830.0"]),
                      _buildCasingDataRow(['Liner', "7.000", "26.000", "6.276", "7590.0", "9053.0", "1463.0"]),
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

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildCasingDataRow(List<String> values) {
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40, // Increased height
          child: c.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                )
              : TextFormField(
                  initialValue: value,
                  style: TextStyle(fontSize: 11),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                    ),
                  ),
                ),
        );
      }).toList(),
    );
  }
}

// ==================== OPEN HOLE SECTION ====================
class OpenHoleSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.explore, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Open Hole",
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
          Obx(() => Padding(
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
                1: FixedColumnWidth(70),
                2: FixedColumnWidth(90),
                3: FixedColumnWidth(90),
              },
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfff0f9ff),
                  ),
                  children: [
                    _buildTableHeaderCell("Description", TextAlign.left),
                    _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                    _buildTableHeaderCell("MD\n(ft)", TextAlign.center),
                    _buildTableHeaderCell("Washout\n(%)", TextAlign.center),
                  ],
                ),

                // Data row
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  children: [
                    _buildOpenHoleCell('8.5" Hole', 0),
                    _buildOpenHoleCell("8.500", 1),
                    _buildOpenHoleCell("9055.0", 2),
                    _buildOpenHoleCell("", 3),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  Widget _buildOpenHoleCell(String value, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 40, // Increased height
      child: c.isLocked.value
          ? Text(
              value,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
              textAlign: index == 0 ? TextAlign.left : TextAlign.center,
            )
          : TextFormField(
              initialValue: value,
              style: TextStyle(fontSize: 11),
              textAlign: index == 0 ? TextAlign.left : TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                ),
              ),
            ),
    );
  }
}

// ==================== DRILL STRING SECTION ====================
class DrillStringSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Drill String",
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
            constraints: BoxConstraints(maxHeight: 250),
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
                    1: FixedColumnWidth(70),
                    2: FixedColumnWidth(90),
                    3: FixedColumnWidth(70),
                    4: FixedColumnWidth(90),
                  },
                  children: [
                    // Header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xfff0f9ff),
                      ),
                      children: [
                        _buildTableHeaderCell("Description", TextAlign.left),
                        _buildTableHeaderCell("OD\n(in)", TextAlign.center),
                        _buildTableHeaderCell("Wt.\n(lb/ft)", TextAlign.center),
                        _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                        _buildTableHeaderCell("Len.\n(ft)", TextAlign.center),
                      ],
                    ),

                    // Data rows
                    _buildDrillStringDataRow(['DP', "5.000", "", "4.276", "7430.4"]),
                    _buildDrillStringDataRow(['X-OVER', "6.500", "", "2.630", "2.3"]),
                    _buildDrillStringDataRow(['DP', "4.000", "", "3.340", "851.5"]),
                    _buildDrillStringDataRow(['HWDP', "4.000", "", "2.438", "92.3"]),
                    _buildDrillStringDataRow(['JAR', "4.750", "", "2.250", "19.8"]),
                    _buildDrillStringDataRow(['HWDP', "4.000", "", "2.438", "551.7"]),
                    _buildDrillStringDataRow(['DC', "4.750", "", "3.340", "31.1"]),
                    _buildDrillStringDataRow(['BIT SUB', "4.750", "", "2.000", "3.0"]),
                  ],
                ),
              ),
            ),
          )),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xfff0f9ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total String Length < Well Depth",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff0d9488),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Total Length (ft): ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0d9488),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff0d9488),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "8982.0",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildDrillStringDataRow(List<String> values) {
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40, // Increased height
          child: c.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                )
              : TextFormField(
                  initialValue: value,
                  style: TextStyle(fontSize: 11),
                  textAlign: index == 0 ? TextAlign.left : TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                    ),
                  ),
                ),
        );
      }).toList(),
    );
  }
}

// ==================== RIGHT PORTION ====================
class RightPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BitSection(),
        const SizedBox(height: 12),
        NozzleSection(),
        const SizedBox(height: 12),
        TimeDistributionSection(),
      ],
    );
  }
}

// ==================== BIT SECTION ====================
class BitSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.diamond, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Bit Information",
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildBitRow("Type", "PDC"),
                SizedBox(height: 6),
                _buildBitRow("Size (in)", "8.5"),
                SizedBox(height: 6),
                _buildBitRow("Serial #", "12345"),
                SizedBox(height: 6),
                _buildBitRow("Run #", "1"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBitRow(String label, String value) {
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
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff2c3e50),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Obx(() => c.isLocked.value
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  : TextFormField(
                      initialValue: value,
                      style: TextStyle(fontSize: 11),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                        ),
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== NOZZLE SECTION ====================
class NozzleSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Nozzle Information",
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
          Obx(() => Padding(
            padding: const EdgeInsets.all(12),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
                width: 1,
                borderRadius: BorderRadius.circular(4),
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(60),
                1: FixedColumnWidth(100),
              },
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfff0f9ff),
                  ),
                  children: [
                    _buildNozzleHeaderCell("No.", TextAlign.center),
                    _buildNozzleHeaderCell("Size\n(1/32in)", TextAlign.center),
                  ],
                ),

                // Data rows
                _buildNozzleTableRow(["1", "14"]),
                _buildNozzleTableRow(["2", ""]),
                _buildNozzleTableRow(["3", ""]),
              ],
            ),
          )),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xfff0f9ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TFA (in²)",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0d9488),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xff0d9488),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "0.518",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNozzleHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildNozzleTableRow(List<String> values) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
        color: Colors.white,
      ),
      children: values.asMap().entries.map((entry) {
        final value = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40, // Increased height
          child: c.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                )
              : TextFormField(
                  initialValue: value,
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                    ),
                  ),
                ),
        );
      }).toList(),
    );
  }
}

// ==================== TIME DISTRIBUTION SECTION ====================
class TimeDistributionSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with teal color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488), // Teal color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Time Distribution",
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
            constraints: BoxConstraints(maxHeight: 250),
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
                    0: FixedColumnWidth(40),
                    1: FixedColumnWidth(140),
                    2: FixedColumnWidth(70),
                  },
                  children: [
                    // Header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xfff0f9ff),
                      ),
                      children: [
                        _buildTimeHeaderCell("#", TextAlign.center),
                        _buildTimeHeaderCell("Activity", TextAlign.left),
                        _buildTimeHeaderCell("Time\n(hr)", TextAlign.center),
                      ],
                    ),

                    // Data rows
                    _buildTimeDistributionRow(["1", "NLDR BOP", "2.00"]),
                    _buildTimeDistributionRow(["2", "Install Wellhead", "2.30"]),
                    _buildTimeDistributionRow(["3", "NLDR BOP", "3.00"]),
                    _buildTimeDistributionRow(["4", "Pressure Test", "3.00"]),
                    _buildTimeDistributionRow(["5", "Others", "2.00"]),
                    _buildTimeDistributionRow(["6", "Circulation", "1.30"]),
                    _buildTimeDistributionRow(["7", "Tripping", "4.00"]),
                    _buildTimeDistributionRow(["8", "Drilling Cement", "6.40"]),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTimeHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildTimeDistributionRow(List<String> values) {
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40, // Increased height
          child: c.isLocked.value
              ? Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: index == 1 ? TextAlign.left : TextAlign.center,
                )
              : TextFormField(
                  initialValue: value,
                  style: TextStyle(fontSize: 11),
                  textAlign: index == 1 ? TextAlign.left : TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0d9488), width: 1),
                    ),
                  ),
                ),
        );
      }).toList(),
    );
  }
}