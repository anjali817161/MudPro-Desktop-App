import 'package:flutter/material.dart';

class DailyCostTableUsagePage extends StatefulWidget {
  const DailyCostTableUsagePage({super.key});

  @override
  State<DailyCostTableUsagePage> createState() =>
      _DailyCostTableUsagePageState();
}

class _DailyCostTableUsagePageState extends State<DailyCostTableUsagePage> {
  final ScrollController _horizontal = ScrollController();
  final ScrollController _vertical = ScrollController();

  // 🔹 Fixed column widths (VERY IMPORTANT)
  final List<double> colWidths = [
    60,  // #
    160, // Category
    200, // Item
    80,  // Price
    80,  // Rec
    80,  // Ret
    80,  // Used
    80,  // Initial
    80,  // Rec
    80,  // Ret
    80,  // Adj
    80,  // Used
    80,  // Final
    100, // Subtotal
    80,  // Cost $
    80,  // Cost %
    80,  // Total $
    80,  // Total %
  ];

  double get tableWidth =>
      colWidths.reduce((a, b) => a + b);

  Widget _cell(String text,
      {double width = 80,
      bool bold = false,
      Color? bg,
      Alignment align = Alignment.center}) {
    return Container(
      width: width,
      height: 32, // 👈 compact row height
      alignment: align,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Column(
      children: [
        // 🔹 MAIN HEADER
        Row(children: [
          _cell('#', width: colWidths[0], bold: true),
          _cell('Category', width: colWidths[1], bold: true),
          _cell('Item', width: colWidths[2], bold: true),
          _cell('Price', width: colWidths[3], bold: true),
          _cell('Cumulative', width: colWidths[4] * 3, bold: true),
          _cell('Initial', width: colWidths[7], bold: true),
          _cell('Rec.', width: colWidths[8], bold: true),
          _cell('Ret.', width: colWidths[9], bold: true),
          _cell('Adj.', width: colWidths[10], bold: true),
          _cell('Used', width: colWidths[11], bold: true),
          _cell('Final', width: colWidths[12], bold: true),
          _cell('Subtotal', width: colWidths[13], bold: true),
          _cell('Cost', width: colWidths[14] * 2, bold: true),
          _cell('Total', width: colWidths[16] * 2, bold: true),
        ]),

        // 🔹 SUB HEADER
        Row(children: [
          _cell('', width: colWidths[0]),
          _cell('', width: colWidths[1]),
          _cell('', width: colWidths[2]),
          _cell('', width: colWidths[3]),
          _cell('Rec.', width: colWidths[4], bold: true),
          _cell('Ret.', width: colWidths[5], bold: true),
          _cell('Used', width: colWidths[6], bold: true),
          _cell('', width: colWidths[7]),
          _cell('', width: colWidths[8]),
          _cell('', width: colWidths[9]),
          _cell('', width: colWidths[10]),
          _cell('', width: colWidths[11]),
          _cell('', width: colWidths[12]),
          _cell('', width: colWidths[13]),
          _cell('\$', width: colWidths[14], bold: true),
          _cell('%', width: colWidths[15], bold: true),
          _cell('\$', width: colWidths[16], bold: true),
          _cell('%', width: colWidths[17], bold: true),
        ]),
      ],
    );
  }

  // ================= ROW =================
  Widget _row(int index, String category, String item,
      {bool isTotal = false, Color? bg}) {
    return Row(children: [
      _cell(index.toString(), width: colWidths[0], bg: bg),
      _cell(category, width: colWidths[1], bg: bg),
      _cell(item, width: colWidths[2], align: Alignment.centerLeft, bg: bg),
      _cell('12.50', width: colWidths[3], bg: bg),
      _cell('10', width: colWidths[4], bg: bg),
      _cell('2', width: colWidths[5], bg: bg),
      _cell('8', width: colWidths[6], bg: bg),
      _cell('0', width: colWidths[7], bg: bg),
      _cell('0', width: colWidths[8], bg: bg),
      _cell('0', width: colWidths[9], bg: bg),
      _cell('0', width: colWidths[10], bg: bg),
      _cell('8', width: colWidths[11], bg: bg),
      _cell('8', width: colWidths[12], bg: bg),
      _cell('100', width: colWidths[13], bg: bg),
      _cell('500', width: colWidths[14], bg: bg),
      _cell('75%', width: colWidths[15], bg: bg),
      _cell('500', width: colWidths[16], bg: bg),
      _cell('75%', width: colWidths[17], bg: bg),
    ]);
  }

  // ================= SUMMARY ROW =================
  Widget _summaryRow(String label, String value) {
    return Row(children: [
      _cell('', width: tableWidth - colWidths.last),
      _cell(value, width: colWidths.last, bold: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Scrollbar(
          controller: _horizontal,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _horizontal,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Column(
                children: [
                  _header(),
                  Expanded(
                    child: Scrollbar(
                      controller: _vertical,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _vertical,
                        child: Column(
                          children: [
                            // PRODUCT ROWS
                            for (int i = 1; i <= 20; i++)
                              _row(i, 'Product', 'Item $i'),

                            _row(0, 'Product Total', '',
                                isTotal: true,
                                bg: Colors.blue.shade50),

                            // ENGINEERING
                            for (int i = 21; i <= 30; i++)
                              _row(i, 'Engineering', 'Item $i'),

                            _row(0, 'Engineering Total', '',
                                isTotal: true,
                                bg: Colors.purple.shade50),

                            // 🔹 FIXED SUMMARY (NO COLUMNS)
                            const SizedBox(height: 8),
                            _summaryRow('Subtotal', '3655.70'),
                            _summaryRow('Tax', '0.00'),
                            _summaryRow('Daily Total', '3655.70'),
                            _summaryRow('Prev Total', '0.00'),
                            _summaryRow('Cum Total', '3655.70'),
                            _summaryRow('Interval Total', '0.00'),
                            _summaryRow('Stock Balance', '3655.70'),
                            _summaryRow('Bulk Setup Fee', '0.00'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
