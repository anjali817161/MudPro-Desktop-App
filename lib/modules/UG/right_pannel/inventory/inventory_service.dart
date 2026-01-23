import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/model/producst_model.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_store/inventory_store.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class InventoryServicesView extends StatefulWidget {
  const InventoryServicesView({super.key});

  @override
  State<InventoryServicesView> createState() => _InventoryServicesViewState();
}

class _InventoryServicesViewState extends State<InventoryServicesView> {
  final RxList<PackageModel> packages = <PackageModel>[].obs;
  final RxList<EngineeringModel> engineering = <EngineeringModel>[].obs;
  final RxList<ServiceModel> services = <ServiceModel>[].obs;

  final isLocked = true.obs;

  @override
  void initState() {
    super.initState();
    loadSelectedData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Auto refresh when page is entered - using addPostFrameCallback for instant update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSelectedData();
    });
  }

  void loadSelectedData() {
    try {
      final store = Get.find<InventoryServicesStore>();

      // Clear first to ensure fresh data
      packages.clear();
      engineering.clear();
      services.clear();

      // Load selected packages with instant update
      final loadedPackages = store.selectedPackages.map((item) => PackageModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        '', // initial
        false, // tax
      )).toList();
      packages.addAll(loadedPackages);

      // Load selected engineering with instant update
      final loadedEngineering = store.selectedEngineering.map((item) => EngineeringModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        false, // tax
      )).toList();
      engineering.addAll(loadedEngineering);

      // Load selected services with instant update
      final loadedServices = store.selectedServices.map((item) => ServiceModel(
        item.id ?? '',
        item.name,
        item.code,
        item.unit,
        item.price.toString(),
        false, // tax
      )).toList();
      services.addAll(loadedServices);
      
      // Force UI update
      packages.refresh();
      engineering.refresh();
      services.refresh();
      
      print('✅ Loaded - Packages: ${packages.length}, Services: ${services.length}, Engineering: ${engineering.length}');
    } catch (e) {
      print('❌ Store not initialized or no data: $e');
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
          height: 28, // Reduced from 32
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            h,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        );
      }).toList(),
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
            0: FixedColumnWidth(35),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
            6: FixedColumnWidth(55),
          }
        : const {
            0: FixedColumnWidth(35),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FixedColumnWidth(55),
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Reduced padding
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9, // Reduced font size
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _editableCell(String value, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), // Reduced padding
      child: Obx(() => isLocked.value
          ? Text(
              value,
              style: TextStyle(
                fontSize: 8.5, // Reduced font size
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
                  fontSize: 8.5, // Reduced font size
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 1), // Reduced padding
                  border: InputBorder.none,
                ),
              ),
            )),
    );
  }

  Widget _checkboxCell(bool value, {Function(bool)? onChanged}) {
    return Center(
      child: Obx(() => Transform.scale(
        scale: 0.75, // Reduced checkbox size
        child: Checkbox(
          value: value,
          onChanged: isLocked.value ? null : (v) => onChanged?.call(v!),
          activeColor: AppTheme.successColor,
          checkColor: Colors.white,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      )),
    );
  }
}