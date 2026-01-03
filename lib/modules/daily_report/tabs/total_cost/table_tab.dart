// ======================== FILE 2: table_tab.dart ========================

import 'package:flutter/material.dart';

class DailyTotalCostTableTab extends StatelessWidget {
  const DailyTotalCostTableTab({super.key});

  static const rowHeight = 28.0; // Slightly smaller row height for 100+ rows

  static const colWidths = [
    50.0,  // No (reduced)
    110.0, // Date (reduced)
    50.0,  // Rpt (reduced)
    90.0,  // MD (reduced)
    130.0, // Product (reduced)
    150.0, // Premixed Mud (reduced)
    110.0, // Package (reduced)
    110.0, // Service (reduced)
    130.0, // Engineering (reduced)
    120.0, // Subtotal (reduced)
    80.0,  // Tax (reduced)
    120.0, // Total (reduced)
  ];

  double get tableWidth => colWidths.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffE2E8F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 101, // header + 100 rows
                  itemBuilder: (context, index) {
                    if (index == 0) return _headerRow();
                    return _dataRow(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _headerRow() {
    final headers = [
      'No',
      'Date',
      'Rpt',
      'MD (ft)',
      'Product',
      'Premixed Mud',
      'Package',
      'Service',
      'Engineering',
      'Subtotal',
      'Tax',
      'Total',
    ];

    return Container(
      height: rowHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff6C9BCF),
            Color(0xff5A8BC5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
      ),
      child: Row(
        children: List.generate(headers.length, (i) {
          return Container(
            width: colWidths[i],
            height: rowHeight,
            padding: EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            child: Text(
              headers[i],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }),
      ),
    );
  }

  // ================= DATA ROW =================
  Widget _dataRow(int index) {
    // Show sample data in first 3 rows, others are empty
    final hasSampleData = index <= 3;
    
    return Container(
      height: rowHeight,
      decoration: BoxDecoration(
        color: index.isOdd ? Colors.white : Color(0xffF8F9FA),
      ),
      child: Row(
        children: List.generate(colWidths.length, (i) {
          return Container(
            width: colWidths[i],
            height: rowHeight,
            padding: EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            child: _buildCellContent(i, index, hasSampleData),
          );
        }),
      ),
    );
  }

  Widget _buildCellContent(int colIndex, int rowIndex, bool hasSampleData) {
    if (hasSampleData) {
      // Sample data for first 3 rows
      final sampleData = [
        ['1', '11/26/2025', '1', '96.0', '3135.70', '0.00', '0.00', '0.00', '520.00', '3655.70', '0.00', '3655.70'],
        ['2', '11/27/2025', '2', '120.5', '2850.00', '150.00', '0.00', '250.00', '480.00', '3730.00', '0.00', '3730.00'],
        ['3', '11/28/2025', '3', '145.8', '3020.50', '0.00', '120.00', '180.00', '490.00', '3810.50', '0.00', '3810.50'],
      ];
      
      final rowData = sampleData[rowIndex - 1];
      
      // For last 3 columns (Subtotal, Tax, Total) in sample rows, show as text
      if (colIndex >= 9 && colIndex <= 11) {
        return Text(
          rowData[colIndex],
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xff2D3748),
          ),
        );
      }
      
      // For other columns in sample rows, show as editable
      return _buildEditableField(rowData[colIndex], colIndex);
    } else {
      // For rows 4-100, show empty editable fields
      return _buildEditableField("", colIndex);
    }
  }

  Widget _buildEditableField(String value, int colIndex) {
    return TextField(
      controller: TextEditingController(text: value),
      style: TextStyle(
        fontSize: 10,
        color: Color(0xff2D3748),
      ),
      textAlign: _getTextAlignment(colIndex),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: _getHintText(colIndex),
        hintStyle: TextStyle(
          fontSize: 10,
          color: Color(0xffCBD5E0),
          fontStyle: FontStyle.italic,
        ),
      ),
      keyboardType: _getKeyboardType(colIndex),
      onChanged: (val) {
        // Handle data change
        // You can add calculation logic here for Subtotal, Tax, Total
      },
    );
  }

  TextAlign _getTextAlignment(int colIndex) {
    if (colIndex == 0 || colIndex == 2) {
      return TextAlign.center;
    }
    return TextAlign.right;
  }

  String _getHintText(int colIndex) {
    switch (colIndex) {
      case 0: return 'No';
      case 1: return 'Date';
      case 2: return 'Rpt';
      case 3: return '0.00';
      case 4: return '0.00';
      case 5: return '0.00';
      case 6: return '0.00';
      case 7: return '0.00';
      case 8: return '0.00';
      case 9: return '0.00';
      case 10: return '0.00';
      case 11: return '0.00';
      default: return '';
    }
  }

  TextInputType _getKeyboardType(int colIndex) {
    if (colIndex == 1) {
      return TextInputType.datetime;
    }
    return TextInputType.numberWithOptions(decimal: true);
  }
}