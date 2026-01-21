import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/products_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Products Management',
                  style: AppTheme.titleLarge.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Text(
                  'Total Products: ${controller.products.length - 1}',
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xffD1D5DB), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildTable(constraints),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Action Buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: AppTheme.secondaryButtonStyle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text('Close'),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // controller.saveProducts();
                    Get.snackbar(
                      'Success',
                      'Products saved successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppTheme.successColor,
                      colorText: Colors.white,
                      margin: EdgeInsets.all(16),
                    );
                  },
                  style: AppTheme.primaryButtonStyle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BoxConstraints constraints) {
    final double minWidth = 1200;
    final double tableWidth = constraints.maxWidth > minWidth ? constraints.maxWidth - 40 : minWidth;

    return Container(
      width: tableWidth,
      child: Column(
        children: [
          // Table Header
          _buildTableHeader(tableWidth),
          
          // Table Rows
          Obx(() => Column(
            children: List.generate(
              controller.products.length,
              (index) => _buildTableRow(index, tableWidth),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeader(double tableWidth) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppTheme.darkPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          _headerCell('No', tableWidth * 0.04),
          _headerCell('Product', tableWidth * 0.14),
          _headerCell('Code', tableWidth * 0.09),
          _headerCell('SG', tableWidth * 0.07),
          // Unit column with sub-headers
          Container(
            width: tableWidth * 0.12,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                right: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Unit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.white.withOpacity(0.2),
                ),
                Container(
                  height: 18,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                            ),
                          ),
                          child: Text(
                            'Num',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Class',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _headerCell('Group', tableWidth * 0.09),
          _headerCell('Retail', tableWidth * 0.09),
          _headerCell('A', tableWidth * 0.06),
          _headerCell('B', tableWidth * 0.06),
      
        ],
      ),
    );
  }

  Widget _headerCell(String title, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTableRow(int index, double tableWidth) {
    final product = controller.products[index];

    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Color(0xffF9FAFB) : Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // No Column
          Container(
            width: tableWidth * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
              ),
            ),
            child: Text(
              '${index + 1}',
              style: AppTheme.bodyLarge.copyWith(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          _buildCell(
            tableWidth * 0.14, 
            product.product, 
            (val) => _updateField(index, 'product', val),
          ),
          _buildCell(
            tableWidth * 0.09, 
            product.code, 
            (val) => _updateField(index, 'code', val),
          ),
          _buildCell(
            tableWidth * 0.07, 
            product.sg, 
            (val) => _updateField(index, 'sg', val),
          ),
          // Unit split column
          Container(
            width: tableWidth * 0.12,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
                right: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
                      ),
                    ),
                    child: _buildCellContent(
                      product.unitNum, 
                      (val) => _updateField(index, 'unitNum', val),
                    ),
                  ),
                ),
                Expanded(
                  child: _buildCellContent(
                    product.unitClass, 
                    (val) => _updateField(index, 'unitClass', val),
                  ),
                ),
              ],
            ),
          ),
          _buildCell(
            tableWidth * 0.09, 
            product.group, 
            (val) => _updateField(index, 'group', val),
          ),
          _buildCell(
            tableWidth * 0.09, 
            product.retail, 
            (val) => _updateField(index, 'retail', val),
          ),
          _buildCell(
            tableWidth * 0.06, 
            product.a, 
            (val) => _updateField(index, 'a', val),
          ),
          _buildCell(
            tableWidth * 0.06, 
            product.b, 
            (val) => _updateField(index, 'b', val),
          ),
        
        ],
      ),
    );
  }

  Widget _buildCell(double width, String value, Function(String) onChanged) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xffE5E7EB), width: 0.5),
        ),
      ),
      child: _buildCellContent(value, onChanged),
    );
  }

  Widget _buildCellContent(String value, Function(String) onChanged) {
    return TextField(
      controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
      style: AppTheme.bodyLarge.copyWith(fontSize: 12),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }

  void _updateField(int index, String field, String value) {
    final product = controller.products[index];
    
    switch (field) {
      case 'product':
        product.product = value;
        break;
      case 'code':
        product.code = value;
        break;
      case 'sg':
        product.sg = value;
        break;
      case 'unitNum':
        product.unitNum = value;
        break;
      case 'unitClass':
        product.unitClass = value;
        break;
      case 'group':
        product.group = value;
        break;
      case 'retail':
        product.retail = value;
        break;
      case 'a':
        product.a = value;
        break;
      case 'b':
        product.b = value;
        break;
      
    }
    
    controller.updateProduct(index, product);
    
    // Auto add new row if current row has any data and it's the last row
    if (index == controller.products.length - 1) {
      if (_hasAnyData(product)) {
        controller.addProduct();
      }
    }
  }

  bool _hasAnyData(product) {
    return product.product.isNotEmpty ||
           product.code.isNotEmpty ||
           product.sg.isNotEmpty ||
           product.unitNum.isNotEmpty ||
           product.unitClass.isNotEmpty ||
           product.group.isNotEmpty ||
           product.retail.isNotEmpty ||
           product.a.isNotEmpty ||
           product.b.isNotEmpty;
         
  }
}