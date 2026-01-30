import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/service_controller.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';
import '../../controller/dashboard_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ConsumeServicesView extends StatefulWidget {
  const ConsumeServicesView({super.key});

  @override
  State<ConsumeServicesView> createState() => _ConsumeServicesViewState();
}

class _ConsumeServicesViewState extends State<ConsumeServicesView> {
  final dashboardController = Get.find<DashboardController>();
  final serviceController = Get.put(ServiceController());
  final RxString selectedMethod = "Used".obs;

  // Data lists
  final RxList<PackageItem> packages = <PackageItem>[].obs;
  final RxList<ServiceItem> services = <ServiceItem>[].obs;
  final RxList<EngineeringItem> engineering = <EngineeringItem>[].obs;

  // Row data for each table
  final RxList<PackageRowData> packageRows = <PackageRowData>[].obs;
  final RxList<ServiceRowData> serviceRows = <ServiceRowData>[].obs;
  final RxList<EngineeringRowData> engineeringRows = <EngineeringRowData>[].obs;

  // Selected row indices for each table
  final RxInt selectedPackageRow = 0.obs;
  final RxInt selectedServiceRow = 0.obs;
  final RxInt selectedEngineeringRow = 0.obs;

  @override
  void initState() {
    super.initState();
    _loadData();
    // Initialize with 5 empty rows each
    for (int i = 0; i < 5; i++) {
      packageRows.add(PackageRowData());
      serviceRows.add(ServiceRowData());
      engineeringRows.add(EngineeringRowData());
    }
  }

  Future<void> _loadData() async {
    try {
      final pkgs = await serviceController.getPackages();
      final srvs = await serviceController.getServices();
      final engs = await serviceController.getEngineering();
      
      packages.value = pkgs;
      services.value = srvs;
      engineering.value = engs;
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio buttons - compact
              Row(
                children: [
                  Text(
                    "Input Method",
                    style: AppTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildCompactRadio("Used", "Used"),
                  const SizedBox(width: 12),
                  _buildCompactRadio("Final", "Final"),
                ],
              ),
              const SizedBox(height: 12),

              // Package Table
              _buildCompactTable(
                title: "Package",
                rows: packageRows,
                dropdownItems: packages,
                selectedRowIndex: selectedPackageRow,
                onDropdownChanged: (index, item) {
                  packageRows[index].selectedItem = item.name;
                  packageRows[index].code = item.code;
                  packageRows[index].unit = item.unit;
                  packageRows[index].price = item.price;
                  packageRows.refresh();
                  _checkAndAddRow(packageRows);
                },
                onFieldChanged: (index) => _checkAndAddRow(packageRows),
                headers: ["Package", "Code", "Unit", "Price (\$)", "Initial", "Used", "Final", "Cost (\$)"],
                color: AppTheme.primaryColor,
              ),

              const SizedBox(height: 12),

              // Services Table
              _buildCompactTable(
                title: "Services",
                rows: serviceRows,
                dropdownItems: services,
                selectedRowIndex: selectedServiceRow,
                onDropdownChanged: (index, item) {
                  serviceRows[index].selectedItem = item.name;
                  serviceRows[index].code = item.code;
                  serviceRows[index].unit = item.unit;
                  serviceRows[index].price = item.price;
                  serviceRows.refresh();
                  _checkAndAddRow(serviceRows);
                },
                onFieldChanged: (index) => _checkAndAddRow(serviceRows),
                headers: ["Services", "Code", "Unit", "Price (\$)", "Usage", "Cost (\$)"],
                color: AppTheme.successColor,
              ),

              const SizedBox(height: 12),

              // Engineering Table
              _buildCompactTable(
                title: "Engineering",
                rows: engineeringRows,
                dropdownItems: engineering,
                selectedRowIndex: selectedEngineeringRow,
                onDropdownChanged: (index, item) {
                  engineeringRows[index].selectedItem = item.name;
                  engineeringRows[index].code = item.code;
                  engineeringRows[index].unit = item.unit;
                  engineeringRows[index].price = item.price;
                  engineeringRows.refresh();
                  _checkAndAddRow(engineeringRows);
                },
                onFieldChanged: (index) => _checkAndAddRow(engineeringRows),
                headers: ["Engineering", "Code", "Unit", "Price (\$)", "Usage", "Cost (\$)"],
                color: AppTheme.infoColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAndAddRow<T extends BaseRowData>(RxList<T> rows) {
    // Check if last row (5th or beyond) is filled
    if (rows.length >= 5) {
      final lastRow = rows.last;
      if (lastRow.selectedItem.isNotEmpty) {
        if (T == PackageRowData) {
          rows.add(PackageRowData() as T);
        } else if (T == ServiceRowData) {
          rows.add(ServiceRowData() as T);
        } else if (T == EngineeringRowData) {
          rows.add(EngineeringRowData() as T);
        }
      }
    }
  }

  Widget _buildCompactRadio(String label, String value) {
    return Obx(() => InkWell(
      onTap: dashboardController.isLocked.value 
          ? null 
          : () => selectedMethod.value = value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selectedMethod.value == value
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
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
              width: 12,
              height: 12,
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
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                fontSize: 11,
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

  Widget _buildCompactTable<T extends BaseRowData, I>({
    required String title,
    required RxList<T> rows,
    required RxList<I> dropdownItems,
    required RxInt selectedRowIndex,
    required Function(int, I) onDropdownChanged,
    required Function(int) onFieldChanged,
    required List<String> headers,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Text(
              title,
              style: AppTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.white,
              ),
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
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                    dataTextStyle: AppTheme.bodySmall.copyWith(
                      fontSize: 10,
                    ),
                    columns: headers.map((h) => DataColumn(
                      label: Container(
                        width: _getColumnWidth(h),
                        alignment: h.contains('Price') || h.contains('Cost') || h.contains('Initial') || h.contains('Used') || h.contains('Final') || h.contains('Usage')
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(h),
                      ),
                    )).toList(),
                    rows: List.generate(rows.length, (index) {
                      final row = rows[index];
                      final isSelected = selectedRowIndex.value == index;
                      
                      return DataRow(
                        color: MaterialStateProperty.all(
                          index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                        ),
                        cells: _buildRowCells(
                          row: row,
                          index: index,
                          isSelected: isSelected,
                          dropdownItems: dropdownItems,
                          onDropdownChanged: onDropdownChanged,
                          onFieldChanged: onFieldChanged,
                          onRowSelected: () => selectedRowIndex.value = index,
                          headers: headers,
                        ),
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

  double _getColumnWidth(String header) {
    if (header.contains('Package') || header.contains('Services') || header.contains('Engineering')) {
      return 180;
    } else if (header == 'Code') {
      return 100;
    } else if (header == 'Unit') {
      return 80;
    } else if (header.contains('Price') || header.contains('Cost')) {
      return 100;
    } else {
      return 90;
    }
  }

  List<DataCell> _buildRowCells<T extends BaseRowData, I>({
    required T row,
    required int index,
    required bool isSelected,
    required RxList<I> dropdownItems,
    required Function(int, I) onDropdownChanged,
    required Function(int) onFieldChanged,
    required VoidCallback onRowSelected,
    required List<String> headers,
  }) {
    List<DataCell> cells = [];

    // First column - Dropdown with icon
    cells.add(DataCell(
      GestureDetector(
        onTap: onRowSelected,
        child: Container(
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
              
              // Dropdown
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<I>(
                    value: row.selectedItem.isNotEmpty 
                        ? dropdownItems.firstWhereOrNull((item) {
                            if (item is PackageItem) return item.name == row.selectedItem;
                            if (item is ServiceItem) return item.name == row.selectedItem;
                            if (item is EngineeringItem) return item.name == row.selectedItem;
                            return false;
                          })
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
                    icon: const SizedBox.shrink(),
                    menuMaxHeight: 250,
                    items: dropdownItems.map((item) {
                      String name = '';
                      if (item is PackageItem) name = item.name;
                      if (item is ServiceItem) name = item.name;
                      if (item is EngineeringItem) name = item.name;
                      
                      return DropdownMenuItem<I>(
                        value: item,
                        child: Text(
                          name,
                          style: AppTheme.bodySmall.copyWith(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: dashboardController.isLocked.value 
                        ? null 
                        : (I? value) {
                            if (value != null) {
                              onRowSelected();
                              onDropdownChanged(index, value);
                            }
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    // Code
    cells.add(DataCell(
      Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(row.code, style: AppTheme.bodySmall.copyWith(fontSize: 10)),
      ),
    ));

    // Unit
    cells.add(DataCell(
      Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(row.unit, style: AppTheme.bodySmall.copyWith(fontSize: 10)),
      ),
    ));

    // Price
    cells.add(DataCell(
      Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          row.price > 0 ? row.price.toStringAsFixed(2) : '',
          style: AppTheme.bodySmall.copyWith(fontSize: 10),
          textAlign: TextAlign.right,
        ),
      ),
    ));

    // Additional fields based on table type
    if (row is PackageRowData) {
      // Initial, Used, Final, Cost
      cells.add(_buildEditableCell(row.initial, (val) {
        row.initial = val;
        onFieldChanged(index);
      }, 90));
      cells.add(_buildEditableCell(row.used, (val) {
        row.used = val;
        onFieldChanged(index);
      }, 90));
      cells.add(_buildEditableCell(row.final_, (val) {
        row.final_ = val;
        onFieldChanged(index);
      }, 90));
      cells.add(DataCell(
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            row.calculateCost().toStringAsFixed(2),
            style: AppTheme.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ));
    } else {
      // Usage, Cost
      cells.add(_buildEditableCell(row is ServiceRowData ? row.usage : (row as EngineeringRowData).usage, (val) {
        if (row is ServiceRowData) {
          row.usage = val;
        } else if (row is EngineeringRowData) {
          row.usage = val;
        }
        onFieldChanged(index);
      }, 90));
      cells.add(DataCell(
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            row.calculateCost().toStringAsFixed(2),
            style: AppTheme.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ));
    }

    return cells;
  }

  DataCell _buildEditableCell(String value, Function(String) onChanged, double width) {
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
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Base class for row data
abstract class BaseRowData {
  String selectedItem = '';
  String code = '';
  String unit = '';
  double price = 0.0;

  double calculateCost();
}

class PackageRowData extends BaseRowData {
  String initial = '';
  String used = '';
  String final_ = '';

  @override
  double calculateCost() {
    final usedVal = double.tryParse(used) ?? 0.0;
    return price * usedVal;
  }
}

class ServiceRowData extends BaseRowData {
  String usage = '';

  @override
  double calculateCost() {
    final usageVal = double.tryParse(usage) ?? 0.0;
    return price * usageVal;
  }
}

class EngineeringRowData extends BaseRowData {
  String usage = '';

  @override
  double calculateCost() {
    final usageVal = double.tryParse(usage) ?? 0.0;
    return price * usageVal;
  }
}