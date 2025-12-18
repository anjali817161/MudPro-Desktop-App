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
                    // LEFT PORTION - General section with proper table
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 300, maxWidth: 400),
                      child: LeftPortion(),
                    ),
                    const SizedBox(width: 12),
                    // MIDDLE PORTION - Cased Hole, Open Hole, Drill String
                    Expanded(
                      flex: 1,
                      child: MiddlePortion(),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT PORTION - Bit, Nozzle, Time Distribution
                    Expanded(
                      flex: 1,
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

// ==================== GENERAL SECTION WITH PROPER TABLE ====================
class GeneralSection extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        color: const Color(0xffFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "General",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          
          // Vertical list of label-value pairs
          Column(
            children: [
              _buildVerticalRow("Report #", "12"),
             
              _buildVerticalRow("User Report #", ""),
            
             
              _buildVerticalRow("Date", "12/27/2025"),
             
           
              _buildVerticalRow("Time", "23:30"),
             
            
              _buildVerticalRow("Engineer", "Keyur Agarwal"),
            
              _buildVerticalRow("Bit #", "120.0 (°F)"),
              _buildVerticalRow("Engineer 2", ""),
            
              _buildVerticalRow("Bottom T.", "180.0 (°F)"),
              _buildVerticalRow("Operator Rep.", "Chandra Shekhar"),
             
              _buildVerticalRow("Contractor Rep.", "Wang"),
           
              _buildVerticalRow("Activity", "Drilling Cement"),
               _buildVerticalRow("MD", "9055.0 (ft)"),
                 _buildVerticalRow("TVD", "8603.0 (ft)"),
            
               _buildVerticalRow("Inc", "73.45 (°)"),
                _buildVerticalRow("Azi", "206.00 (°)"),
                  _buildVerticalRow("WOB", "10000 (lbf)"),
                    _buildVerticalRow("Rot. Wt.", "(lbf)"),
                     _buildVerticalRow("S/O Wt.", "(lbf)"),
                        _buildVerticalRow("P/U Wt.", "(lbf)"),
                          _buildVerticalRow("RPM", "70.0 (rpm)"),
                           _buildVerticalRow("ROP", "30 (ft/hr)"),
                              _buildVerticalRow("Off-bottom TQ", "4000 (ft-lb)"),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<Widget> cells) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      children: cells,
    );
  }

  Widget _buildTableCell(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      height: 32,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => c.isLocked.value
                ? Text(
                    value,
                    style: const TextStyle(fontSize: 10),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextFormField(
                      initialValue: value,
                      style: const TextStyle(fontSize: 10),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => c.isLocked.value
                ? Text(
                    value,
                    style: const TextStyle(fontSize: 10),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextFormField(
                      initialValue: value,
                      style: const TextStyle(fontSize: 10),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Cased Hole",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Container(child: Text("Add New Casing"),
                
                
                 ), 
                 
                ElevatedButton(
                  onPressed: () {
                    // Add new casing logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    minimumSize: Size.zero,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          // Table
          Obx(() => Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(color: Colors.black, width: 0.5),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(120),
                  1: FixedColumnWidth(50),
                  2: FixedColumnWidth(60),
                  3: FixedColumnWidth(50),
                  4: FixedColumnWidth(60),
                  5: FixedColumnWidth(60),
                  6: FixedColumnWidth(60),
                },
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                    ),
                    children: [
                      _buildTableHeaderCell("Description"),
                      _buildTableHeaderCell("OD\n(in)"),
                      _buildTableHeaderCell("Wt.\n(lb/ft)"),
                      _buildTableHeaderCell("ID\n(in)"),
                      _buildTableHeaderCell("Top\n(ft)"),
                      _buildTableHeaderCell("Shoe\n(ft)"),
                      _buildTableHeaderCell("Len.\n(ft)"),
                    ],
                  ),
                  
                  // Data rows
                  _buildCasingDataRow(['9 5/8" Casing', "9.625", "47.000", "8.681", "0.0", "7830.0", "7830.0"]),
                  _buildCasingDataRow(['Liner', "7.000", "26.000", "6.276", "7590.0", "9053.0", "1463.0"]),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildCasingDataRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 28,
        child: c.isLocked.value
            ? Text(
                value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              )
            : TextFormField(
                initialValue: value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
              ),
      )).toList(),
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
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "Open Hole",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Table
          Obx(() => Table(
            
            border: TableBorder.all(color: Colors.grey, width: 0.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FixedColumnWidth(60),
              2: FixedColumnWidth(80),
              3: FixedColumnWidth(80),
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0F0),
                ),
                children: [
                  _buildTableHeaderCell("Description"),
                  _buildTableHeaderCell("ID\n(in)"),
                  _buildTableHeaderCell("MD\n(ft)"),
                  _buildTableHeaderCell("Washout\n(%)"),
                ],
              ),

              // Data row
              _buildOpenHoleDataRow(['8.5" Hole', "8.500", "9055.0", ""]),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildOpenHoleDataRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 28,
        child: c.isLocked.value
            ? Text(
                value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              )
            : TextFormField(
                initialValue: value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
              ),
      )).toList(),
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
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "Drill String",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Table
          Obx(() => Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(color: Colors.black, width: 0.5),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(100),
                  1: FixedColumnWidth(60),
                  2: FixedColumnWidth(80),
                  3: FixedColumnWidth(60),
                  4: FixedColumnWidth(80),
                },
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                    ),
                    children: [
                      _buildTableHeaderCell("Description"),
                      _buildTableHeaderCell("OD\n(in)"),
                      _buildTableHeaderCell("Wt.\n(lb/ft)"),
                      _buildTableHeaderCell("ID\n(in)"),
                      _buildTableHeaderCell("Len.\n(ft)"),
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
          )),

          // Footer
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffFFF9E6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total String Length < Well Depth",
                  style: TextStyle(fontSize: 10),
                ),
                Row(
                  children: [
                    const Text(
                      "Total Length (ft): ",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "8982.0",
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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

  Widget _buildTableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildDrillStringDataRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 28,
        child: c.isLocked.value
            ? Text(
                value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              )
            : TextFormField(
                initialValue: value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
              ),
      )).toList(),
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
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "Bit",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Table
          Table(
            border: TableBorder.all(color: Colors.black, width: 0.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(80),
              1: FixedColumnWidth(120),
            },
            children: [
              _buildBitTableRow(["Type", "PDC"]),
              _buildBitTableRow(["Size (in)", "8.5"]),
              _buildBitTableRow(["Serial #", "12345"]),
              _buildBitTableRow(["Run #", "1"]),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildBitTableRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        height: 32,
        child: Row(
          children: [
            if (value == values[0]) // Label
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (value != values[0]) // Value
              Expanded(
                child: Obx(() => c.isLocked.value
                    ? Text(
                        value,
                        style: const TextStyle(fontSize: 10),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFormField(
                          initialValue: value,
                          style: const TextStyle(fontSize: 10),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
              ),
          ],
        ),
      )).toList(),
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
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "Nozzle (1/32in)",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Table
          Obx(() => Table(
            border: TableBorder.all(color: Colors.black, width: 0.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(80),
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0F0),
                ),
                children: [
                  _buildTableHeaderCell(""),
                  _buildTableHeaderCell("Size\n(1/32in)"),
                ],
              ),

              // Data rows
              _buildNozzleTableRow(["1", "14"]),
              _buildNozzleTableRow(["2", ""]),
              _buildNozzleTableRow(["3", ""]),
            ],
          )),

          // Footer
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffFFF9E6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TFA (in2)",
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  "0.518",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildNozzleTableRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 28,
        child: c.isLocked.value
            ? Text(
                value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              )
            : TextFormField(
                initialValue: value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
              ),
      )).toList(),
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
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xffE0E0E0),
            child: const Text(
              "Time Distribution",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Table
          Obx(() => Table(
            border: TableBorder.all(color: Colors.black, width: 0.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(140),
              2: FixedColumnWidth(60),
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0F0),
                ),
                children: [
                  _buildTableHeaderCell(""),
                  _buildTableHeaderCell("Activity"),
                  _buildTableHeaderCell("Time\n(hr)"),
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
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTimeDistributionRow(List<String> values) {
    return TableRow(
      children: values.map((value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 28,
        child: c.isLocked.value
            ? Text(
                value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              )
            : TextFormField(
                initialValue: value,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
              ),
      )).toList(),
    );
  }
}
