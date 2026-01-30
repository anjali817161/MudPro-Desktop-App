import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/ug_pit_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/model/pit_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/products_controller.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/products_model.dart';
import '../../controller/operation_controller.dart';
import '../../controller/dashboard_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ConsumeProductView extends StatefulWidget {
  const ConsumeProductView({super.key});

  @override
  State<ConsumeProductView> createState() => _ConsumeProductViewState();
}

class _ConsumeProductViewState extends State<ConsumeProductView> {
  final OperationController operationController = Get.find<OperationController>();
  final DashboardController dashboardController = Get.find<DashboardController>();
  final ProductsController productsController = Get.put(ProductsController());
  final PitController pitController = Get.put(PitController());
  
  final RxString selectedMethod = "Used".obs;
  final RxBool addWater = false.obs;
  final TextEditingController waterVolumeController = TextEditingController();
  final TextEditingController totalVolumeController = TextEditingController(text: "2.62");

  // Row data for tables
  final RxList<ProductRowData> productRows = <ProductRowData>[].obs;
  final RxList<DistributeRowData> distributeRows = <DistributeRowData>[].obs;

  // Selected row indices
  final RxInt selectedProductRow = 0.obs;
  final RxInt selectedDistributeRow = 0.obs;

  // Selected products for top dropdown
  final Rx<ProductModel?> selectedTopProduct = Rx<ProductModel?>(null);

  @override
  void initState() {
    super.initState();
    // Initialize with 5 empty rows each
    for (int i = 0; i < 5; i++) {
      productRows.add(ProductRowData());
      distributeRows.add(DistributeRowData());
    }
    // Fetch pits data
    pitController.fetchAllPits();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Controls
              _buildTopControls(),
              const SizedBox(height: 10),

              // Main Product Table
              _buildProductTable(),
              const SizedBox(height: 10),

              // Bottom Section: Distribute Table + Right Controls
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Select Products Dropdown
          Expanded(
            flex: 2,
            child: _buildProductDropdown(),
          ),
          const SizedBox(width: 10),

          // Load Previous Products
          Expanded(
            flex: 2,
            child: _buildDropdown(
              hint: "Load Previous Products",
              icon: Icons.history,
            ),
          ),
          const SizedBox(width: 12),

          // Radio Buttons
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "Input Method",
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 10),
                _buildCompactRadio("Used", "Used"),
                const SizedBox(width: 6),
                _buildCompactRadio("Final", "Final"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDropdown() {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory_2_outlined, size: 14, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: Obx(() => DropdownButtonHideUnderline(
              child: DropdownButton<ProductModel>(
                value: selectedTopProduct.value != null &&
                       productsController.products.any((p) => p.id == selectedTopProduct.value?.id)
                    ? selectedTopProduct.value
                    : null,
                hint: Text(
                  "Select Products",
                  style: AppTheme.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
                icon: Icon(Icons.arrow_drop_down, size: 16),
                isExpanded: true,
                isDense: true,
                menuMaxHeight: 300,
                items: productsController.products.where((p) => p.id != null).map((product) {
                  return DropdownMenuItem<ProductModel>(
                    value: product,
                    child: Text(
                      product.product,
                      style: AppTheme.bodySmall.copyWith(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: dashboardController.isLocked.value 
                    ? null 
                    : (ProductModel? value) {
                        selectedTopProduct.value = value;
                      },
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({required String hint, required IconData icon}) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  hint,
                  style: AppTheme.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
                icon: Icon(Icons.arrow_drop_down, size: 16),
                items: [],
                onChanged: dashboardController.isLocked.value ? null : (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRadio(String label, String value) {
    return Obx(() => InkWell(
      onTap: dashboardController.isLocked.value 
          ? null 
          : () => selectedMethod.value = value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: selectedMethod.value == value
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: selectedMethod.value == value
                ? AppTheme.primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedMethod.value == value
                      ? AppTheme.primaryColor
                      : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: selectedMethod.value == value
                  ? Center(
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                fontSize: 10,
                color: selectedMethod.value == value
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildProductTable() {
    final headers = [
      "Product",
      "Code",
      "SG",
      "Unit",
      "Price (\$)",
      "Initial",
      "Adjust",
      "Used",
      "Final",
      "Cost (\$)",
      "Vol (bbl)",
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.inventory_2, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Consume Product",
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table with fixed height and scrollable content
          SizedBox(
            height: 220, // Fixed height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(() => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: DataTable(
                    headingRowHeight: 32,
                    dataRowHeight: 32,
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    dividerThickness: 0,
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                    border: TableBorder(
                      verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                      horizontalInside: BorderSide(color: Colors.grey.shade200, width: 1),
                    ),
                    headingTextStyle: AppTheme.bodySmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                    dataTextStyle: AppTheme.bodySmall.copyWith(fontSize: 10),
                    columns: headers.map((h) => DataColumn(
                      label: Container(
                        width: _getProductColumnWidth(h),
                        alignment: h.contains('Price') || h.contains('Cost') || h.contains('Initial') || 
                                   h.contains('Adjust') || h.contains('Used') || h.contains('Final') || h.contains('Vol')
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(h),
                      ),
                    )).toList(),
                    rows: List.generate(productRows.length, (index) {
                      final row = productRows[index];
                      final isSelected = selectedProductRow.value == index;
                      
                      return DataRow(
                        color: MaterialStateProperty.all(
                          index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                        ),
                        cells: _buildProductCells(row, index, isSelected),
                      );
                    }),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getProductColumnWidth(String header) {
    if (header == 'Product') {
      return 150;
    } else if (header == 'Code') {
      return 80;
    } else if (header == 'SG' || header == 'Unit') {
      return 70;
    } else if (header.contains('Price') || header.contains('Cost')) {
      return 85;
    } else {
      return 75;
    }
  }

  List<DataCell> _buildProductCells(ProductRowData row, int index, bool isSelected) {
    List<DataCell> cells = [];

    // Product Dropdown with icon
    cells.add(DataCell(
      GestureDetector(
        onTap: () => selectedProductRow.value = index,
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            children: [
              // Dropdown icon - shows only in selected row
              if (isSelected)
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
              if (isSelected)
                const SizedBox(width: 4),
              
              Expanded(
                child: Obx(() => DropdownButtonHideUnderline(
                  child: DropdownButton<ProductModel>(
                    value: row.selectedProduct.value != null &&
                           productsController.products.any((p) => p.id == row.selectedProduct.value?.id)
                        ? row.selectedProduct.value
                        : null,
                    hint: Text(
                      "Select",
                      style: AppTheme.bodySmall.copyWith(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    isExpanded: true,
                    isDense: true,
                    icon: const SizedBox.shrink(), // Hide default icon
                    menuMaxHeight: 300,
                    items: productsController.products.where((p) => p.id != null).map((product) {
                      return DropdownMenuItem<ProductModel>(
                        value: product,
                        child: Text(
                          product.product,
                          style: AppTheme.bodySmall.copyWith(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: dashboardController.isLocked.value 
                        ? null 
                        : (ProductModel? value) {
                            if (value != null) {
                              selectedProductRow.value = index;
                              row.selectedProduct.value = value;
                              row.code = value.code;
                              row.sg = value.sg;
                              row.unit = value.unitClass;
                              row.price = value.a.isNotEmpty 
                                  ? double.tryParse(value.a) ?? 0.0 
                                  : 0.0;
                                  row.initial = value.initial;
                              productRows.refresh();
                              _checkAndAddProductRow();
                            }
                          },
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    ));

    // Code
    cells.add(_buildTableCell(row.code, 80, isEditable: false));

    // SG
    cells.add(_buildTableCell(row.sg, 70, isEditable: false));

    // Unit
    cells.add(_buildTableCell(row.unit, 70, isEditable: false));

    // Price
    cells.add(_buildTableCell(
      row.price > 0 ? row.price.toStringAsFixed(2) : '',
      85,
      isEditable: false,
      isRightAligned: true,
    ));

    // Initial
    cells.add(_buildEditableTableCell(row.initial, (val) {
      row.initial = val;
      _checkAndAddProductRow();
    }, 75));

    // Adjust
    cells.add(_buildEditableTableCell(row.adjust, (val) {
      row.adjust = val;
      _checkAndAddProductRow();
    }, 75));

    // Used
    cells.add(_buildEditableTableCell(row.used, (val) {
      row.used = val;
      _checkAndAddProductRow();
    }, 75));

    // Final
    cells.add(_buildEditableTableCell(row.final_, (val) {
      row.final_ = val;
      _checkAndAddProductRow();
    }, 75));

    // Cost
    cells.add(_buildTableCell(
      row.calculateCost().toStringAsFixed(2),
      85,
      isEditable: false,
      isRightAligned: true,
      isBold: true,
    ));

    // Vol
    cells.add(_buildEditableTableCell(row.vol, (val) {
      row.vol = val;
      _checkAndAddProductRow();
    }, 80, isRightAligned: true));

    return cells;
  }

  DataCell _buildTableCell(
    String text,
    double width, {
    bool isEditable = false,
    bool isRightAligned = false,
    bool isBold = false,
  }) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          text,
          style: AppTheme.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
          textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  DataCell _buildEditableTableCell(
    String value,
    Function(String) onChanged,
    double width, {
    bool isRightAligned = false,
  }) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: TextEditingController(text: value),
          enabled: !dashboardController.isLocked.value,
          style: AppTheme.bodySmall.copyWith(fontSize: 10),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          textAlign: isRightAligned ? TextAlign.right : TextAlign.left,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _checkAndAddProductRow() {
    if (productRows.length >= 5) {
      final lastRow = productRows.last;
      if (lastRow.selectedProduct.value != null) {
        productRows.add(ProductRowData());
      }
    }
  }

  Widget _buildBottomSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Distribute Table - Compressed width
        SizedBox(
          width: 280,
          child: _buildDistributeTable(),
        ),
        const SizedBox(width: 12),

        // Right Controls
        Expanded(
          child: _buildRightControls(),
        ),
      ],
    );
  }

  Widget _buildDistributeTable() {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.successColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.share, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Distribute to",
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table with fixed height and scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => DataTable(
                headingRowHeight: 32,
                dataRowHeight: 32,
                columnSpacing: 0,
                horizontalMargin: 0,
                dividerThickness: 0,
                headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                border: TableBorder(
                  verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                  horizontalInside: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                headingTextStyle: AppTheme.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.successColor,
                ),
                dataTextStyle: AppTheme.bodySmall.copyWith(fontSize: 10),
                columns: [
                  DataColumn(
                    label: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Pit"),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Vol (bbl)"),
                    ),
                  ),
                ],
                rows: List.generate(distributeRows.length, (index) {
                  final row = distributeRows[index];
                  final isSelected = selectedDistributeRow.value == index;
                  
                  return DataRow(
                    color: MaterialStateProperty.all(
                      index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                    ),
                    cells: [
                      // Pit Dropdown with icon
                      DataCell(
                        GestureDetector(
                          onTap: () => selectedDistributeRow.value = index,
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                // Dropdown icon - shows only in selected row
                                if (isSelected)
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 16,
                                    color: AppTheme.successColor,
                                  ),
                                if (isSelected)
                                  const SizedBox(width: 4),
                                
                                Expanded(
                                  child: Obx(() => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: row.pit.isNotEmpty ? row.pit : null,
                                      hint: Text(
                                        "Select Pit",
                                        style: AppTheme.bodySmall.copyWith(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      isExpanded: true,
                                      isDense: true,
                                      icon: const SizedBox.shrink(),
                                      menuMaxHeight: 250,
                                      items: pitController.pits
                                          .where((pit) => pit.id != null && pit.pitName.isNotEmpty)
                                          .map((pit) {
                                        return DropdownMenuItem<String>(
                                          value: pit.pitName,
                                          child: Text(
                                            pit.pitName,
                                            style: AppTheme.bodySmall.copyWith(fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: dashboardController.isLocked.value
                                          ? null
                                          : (String? newValue) {
                                              if (newValue != null) {
                                                selectedDistributeRow.value = index;
                                                row.pit = newValue;
                                                // Find the selected pit and set volume to its capacity
                                                final selectedPit = pitController.pits.firstWhere(
                                                  (pit) => pit.pitName == newValue,
                                                  orElse: () => PitModel(pitName: '', capacity: 0.0, initialActive: false),
                                                );
                                                if (selectedPit.pitName.isNotEmpty) {
                                                  row.volume = selectedPit.capacity.value.toString();
                                                }
                                                distributeRows.refresh();
                                                _checkAndAddDistributeRow();
                                              }
                                            },
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Volume
                      DataCell(
                        Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: TextEditingController(text: row.volume),
                            enabled: !dashboardController.isLocked.value,
                            style: AppTheme.bodySmall.copyWith(fontSize: 10),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            onChanged: (val) {
                              row.volume = val;
                              _checkAndAddDistributeRow();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              )),
            ),
          ),
        ],
      ),
    );
  }

  void _checkAndAddDistributeRow() {
    if (distributeRows.length >= 5) {
      final lastRow = distributeRows.last;
      if (lastRow.volume.isNotEmpty) {
        distributeRows.add(DistributeRowData());
      }
    }
  }

  Widget _buildRightControls() {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add Water Checkbox and Water Volume in same row
          Obx(() => Row(
            children: [
              // Add Water Checkbox
              InkWell(
                onTap: dashboardController.isLocked.value 
                    ? null 
                    : () => addWater.value = !addWater.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: addWater.value 
                        ? AppTheme.primaryColor.withOpacity(0.1) 
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: addWater.value 
                          ? AppTheme.primaryColor 
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: addWater.value 
                                ? AppTheme.primaryColor 
                                : Colors.grey.shade400,
                          ),
                          color: addWater.value 
                              ? AppTheme.primaryColor 
                              : Colors.transparent,
                        ),
                        child: addWater.value
                            ? Icon(Icons.check, size: 11, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Add Water",
                        style: AppTheme.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 10),
              
              // Water Volume field (conditional, aligned right)
              if (addWater.value)
                Expanded(
                  child: _buildCompactInputField(
                    controller: waterVolumeController,
                    suffix: "bbl",
                  ),
                ),
            ],
          )),

          const SizedBox(height: 10),

          // Total Volume
          Row(
            children: [
              Text(
                "Total Vol.",
                style: AppTheme.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildCompactInputField(
                  controller: totalVolumeController,
                  suffix: "bbl",
                ),
              ),
            ],
          ),

          const Spacer(),

          // Note
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 13, color: Colors.amber.shade700),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Products distributed evenly if multiple pits selected",
                    style: AppTheme.bodySmall.copyWith(
                      fontSize: 9,
                      color: Colors.amber.shade900,
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

  Widget _buildCompactInputField({
    required TextEditingController controller,
    required String suffix,
  }) {
    return Obx(() => Container(
      height: 32,
      decoration: BoxDecoration(
        color: dashboardController.isLocked.value 
            ? Colors.grey.shade50 
            : Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: !dashboardController.isLocked.value,
              style: AppTheme.bodySmall.copyWith(fontSize: 10),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
            ),
            child: Center(
              child: Text(
                suffix,
                style: AppTheme.bodySmall.copyWith(
                  fontSize: 10,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

// Product Row Data Model
class ProductRowData {
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  String code = '';
  String sg = '';
  String unit = '';
  double price = 0.0;
  String initial = '';
  String adjust = '';
  String used = '';
  String final_ = '';
  String vol = '';

  double calculateCost() {
    final usedVal = double.tryParse(used) ?? 0.0;
    return price * usedVal;
  }
}

// Distribute Row Data Model
class DistributeRowData {
  String pit = '';
  String volume = '';
}