import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/model/producst_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/service_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class InventoryServicesView extends StatefulWidget {
  const InventoryServicesView({super.key});

  @override
  State<InventoryServicesView> createState() => _InventoryServicesViewState();
}

class _InventoryServicesViewState extends State<InventoryServicesView> {
  final ServiceController controller = ServiceController();

  final RxList<PackageModel> packages = <PackageModel>[].obs;
  final RxList<EngineeringModel> engineering = <EngineeringModel>[].obs;
  final RxList<ServiceModel> services = <ServiceModel>[].obs;

  final isLocked = true.obs;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedPackages = await controller.getPackages();
      packages.value = fetchedPackages.map((item) => PackageModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        '', // initial
        false, // tax
      )).toList();

      final fetchedEngineering = await controller.getEngineering();
      engineering.value = fetchedEngineering.map((item) => EngineeringModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        false, // tax
      )).toList();

      final fetchedServices = await controller.getServices();
      services.value = fetchedServices.map((item) => ServiceModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        false, // tax
      )).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

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
               
                const SizedBox(height: 4),
                Expanded(
                  child: _packagesTable(),
                ),

                const SizedBox(height: 8),

                // -------- ENGINEERING --------
                
                const SizedBox(height: 4),
                Expanded(
                  child: _engineeringTable(),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ================= RIGHT COLUMN =================
          Expanded(
            flex: 2,
            child: Column(
              children: [
               
                const SizedBox(height: 4),
                Expanded(
                  child: _servicesTable(),
                ),
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
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            decoration: BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.inventory, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Packages',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${packages.length} items',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _table(
              headers: ['No', 'Package', 'Code', 'Unit', 'Price (\$)', 'Initial', 'Tax'],
              rows: packages.asMap().entries.map((entry) => [
                (entry.key + 1).toString(),
                entry.value.package,
                entry.value.code,
                entry.value.unit,
                entry.value.price,
                entry.value.initial,
                entry.value.tax,
              ]).toList(),
              models: packages,
              checkboxCols: [6],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _engineeringTable() {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            decoration: BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.engineering, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Engineering',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${engineering.length} items',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _table(
              headers: ['No', 'Engineering', 'Code', 'Unit', 'Price (\$)', 'Tax'],
              rows: engineering.asMap().entries.map((entry) => [
                (entry.key + 1).toString(),
                entry.value.name,
                entry.value.code,
                entry.value.unit,
                entry.value.price,
                entry.value.tax,
              ]).toList(),
              models: engineering,
              checkboxCols: [5],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _servicesTable() {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            decoration: BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.miscellaneous_services, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${services.length} items',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _table(
              headers: ['No', 'Services', 'Code', 'Unit', 'Price (\$)', 'Tax'],
              rows: services.asMap().entries.map((entry) => [
                (entry.key + 1).toString(),
                entry.value.service,
                entry.value.code,
                entry.value.unit,
                entry.value.price,
                entry.value.tax,
              ]).toList(),
              models: services,
              checkboxCols: [5],
            ),
          ),
        ],
      ),
    ));
  }

TableRow _headerRow(List<String> headers) {
  return TableRow(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.primaryColor.withOpacity(0.05)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    children: headers.map((h) {
      return Container(
        height: 24,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          h,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      );
    }).toList(),
  );
}



TableRow _tableRow(List<dynamic> values, {List<Function(String)?>? onChangedList, List<Function(bool)?>? onCheckboxChangedList}) {
  return TableRow(
    decoration: BoxDecoration(
      color: values.hashCode.isEven ? Colors.white : AppTheme.cardColor,
    ),
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
    (index) => TableRow(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : AppTheme.cardColor,
      ),
      children: List.generate(
        columns,
        (colIndex) => Container(
          height: 32,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: colIndex == 0 
            ? Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              )
            : null,
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
    final columnWidths = headers.length == 7
        ? const {
            0: FixedColumnWidth(40),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
            6: FixedColumnWidth(60),
          }
        : const {
            0: FixedColumnWidth(40),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FixedColumnWidth(60),
          };

    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: columnWidths,
        children: [
          // HEADER
          _headerRow(headers),

          // ROWS
          ...rows.asMap().entries.map((entry) {
            final rowIndex = entry.key;
            final row = entry.value;
            final model = models[rowIndex];
            return TableRow(
              decoration: BoxDecoration(
                color: rowIndex.isEven ? Colors.white : AppTheme.cardColor,
              ),
              children: List.generate(row.length, (i) {
                if (checkboxCols.contains(i)) {
                  return _checkboxCell(row[i], onChanged: (v) {
                    if (model is EngineeringModel) {
                      model.tax = v;
                      engineering.refresh();
                    } else if (model is ServiceModel) {
                      model.tax = v;
                      services.refresh();
                    } else if (model is PackageModel) {
                      model.tax = v;
                      packages.refresh();
                    }
                  });
                }
                return _editableCell(row[i].toString(), onChanged: (v) {
                  if (model is EngineeringModel) {
                    if (i == 1) model.name = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    engineering.refresh();
                  } else if (model is ServiceModel) {
                    if (i == 1) model.service = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    services.refresh();
                  } else if (model is PackageModel) {
                    if (i == 1) model.package = v;
                    if (i == 2) model.code = v;
                    if (i == 3) model.unit = v;
                    if (i == 4) model.price = v;
                    if (i == 5) model.initial = v;
                    packages.refresh();
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _editableCell(String value, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Obx(() => isLocked.value
          ? Text(
              value,
              style: TextStyle(
                fontSize: 9,
                color: AppTheme.textPrimary,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextFormField(
                initialValue: value,
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: 9,
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  border: InputBorder.none,
                ),
              ),
            )),
    );
  }

  Widget _checkboxCell(bool value, {Function(bool)? onChanged}) {
    return Center(
      child: Obx(() => Container(
            decoration: BoxDecoration(
              color: value ? AppTheme.successColor.withOpacity(0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: value ? AppTheme.successColor : Colors.grey.shade400,
              ),
            ),
            margin: const EdgeInsets.all(2),
            child: Checkbox(
              value: value,
              onChanged: isLocked.value ? null : (v) => onChanged?.call(v!),
              activeColor: AppTheme.successColor,
              checkColor: Colors.white,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )),
    );
  }

  Widget _sectionHeader(String text) {
    return Container(
      height: 28,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.08),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}