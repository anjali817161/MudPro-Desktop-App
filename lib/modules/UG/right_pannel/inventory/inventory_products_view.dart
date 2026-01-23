import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/model/producst_model.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/inventory/inventory_store/inventory_store.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/products_model.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class InventoryProductsView extends StatefulWidget {
  const InventoryProductsView({super.key});

  @override
  State<InventoryProductsView> createState() => _InventoryProductsViewState();
}

class _InventoryProductsViewState extends State<InventoryProductsView> {
  final c = Get.find<UgController>();

  @override
  void initState() {
    super.initState();
    // Clear all tables initially to keep them empty
    c.products.clear();
    c.premixed.clear();
    c.obm.clear();
    // Add one empty row for premixed and obm tables
    c.premixed.add(PremixModel(id: '1', description: '', mw: '', leasingFee: '', mudType: '', tax: false));
    c.obm.add(ObmModel(id: '1', product: '', code: '', sg: '', conc: ''));
    // Auto refresh data when page enters
    _refreshData();
  }

  void _refreshData() {
    try {
      final store = Get.find<InventoryProductsStore>();
      // Refresh the observable lists to trigger UI update
      store.selectedProducts.refresh();
      c.products.refresh();
      c.premixed.refresh();
      c.obm.refresh();
      print('✅ Data refreshed on page enter');
    } catch (e) {
      print('❌ Error refreshing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Get.find<InventoryProductsStore>();

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // ================= MAIN PRODUCTS TABLE =================
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  // Table Header
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
                          'Products Inventory',
                          style: TextStyle(
                            fontSize: 13,
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
                          child: Obx(() => Text(
                            '${store.selectedProducts.length} items',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final productsToDisplay = store.selectedProducts;

                      return Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FixedColumnWidth(40),
                                1: FixedColumnWidth(250),
                                2: FixedColumnWidth(140),
                                3: FixedColumnWidth(100),
                                4: FixedColumnWidth(100),
                                5: FixedColumnWidth(100),
                                6: FixedColumnWidth(100),
                                7: FixedColumnWidth(140),
                                8: FixedColumnWidth(80),
                                9: FixedColumnWidth(140),
                                10: FixedColumnWidth(80),
                              },
                              children: [
                                // Header Row
                                TableRow(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.primaryColor.withOpacity(0.05)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  children: [
                                    _tableHeaderCell('No'),
                                    _tableHeaderCell('Product'),
                                    _tableHeaderCell('Code'),
                                    _tableHeaderCell('SG'),
                                    _tableHeaderCell('Unit'),
                                    _tableHeaderCell('Price'),
                                    _tableHeaderCell('Initial'),
                                    _tableHeaderCell('Group'),
                                    _tableHeaderCell('Vol. Add'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _headerText('Concentration'),
                                          const SizedBox(height: 2),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(child: Center(child: _headerText('Calculate', size: 9))),
                                              Expanded(child: Center(child: _headerText('Plot', size: 9))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    _tableHeaderCell('Tax'),
                                  ],
                                ),
                                // Data Rows
                                ...productsToDisplay.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final p = entry.value;
                                  return TableRow(
                                    decoration: BoxDecoration(
                                      color: index.isEven ? Colors.white : AppTheme.cardColor,
                                    ),
                                    children: [
                                      _tableCell((index + 1).toString()),
                                      _editableTableCell(p.product, onChanged: (v) {
                                        p.product = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.code, onChanged: (v) {
                                        p.code = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.sg, onChanged: (v) {
                                        p.sg = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.unitNum, onChanged: (v) {
                                        p.unitClass = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.price, onChanged: (v) {
                                        p.unitNum = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.initial, onChanged: (v) {
                                        p.initial = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _editableTableCell(p.group, onChanged: (v) {
                                        p.group = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      _checkboxCell(() => p.volAdd, (v) {
                                        p.volAdd = v;
                                        store.selectedProducts.refresh();
                                      }),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: _checkboxCell(() => p.calculate, (v) {
                                                p.calculate = v;
                                                store.selectedProducts.refresh();
                                              }),
                                            ),
                                            Expanded(
                                              child: _checkboxCell(() => p.plot ?? false, (v) {
                                                p.plot = v;
                                                store.selectedProducts.refresh();
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _checkboxCell(() => p.tax, (v) {
                                        p.tax = v;
                                        store.selectedProducts.refresh();
                                      }),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ================= BOTTOM TABLES =================
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 800) {
                  return Column(
                    children: [
                      Expanded(child: _premixedMudTable()),
                      const SizedBox(height: 8),
                      Expanded(child: _obmTable()),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(flex: 1, child: _premixedMudTable()),
                      const SizedBox(width: 8),
                      Expanded(flex: 1, child: _obmTable()),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= PREMIXED =================
  Widget _premixedMudTable() {
    return Container(
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
                Icon(Icons.macro_off, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Premixed Mud',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.primaryColor.withOpacity(0.05)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    children: [
                      _tableHeaderCell('#'),
                      _tableHeaderCell('Description'),
                      _tableHeaderCell('MW'),
                      _tableHeaderCell('Leasing Fee'),
                      _tableHeaderCell('Mud Type'),
                      _tableHeaderCell('Tax'),
                    ],
                  ),
                  ...c.premixed.asMap().entries.map((entry) {
                    final index = entry.key;
                    final e = entry.value;
                    return TableRow(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : AppTheme.cardColor,
                      ),
                      children: [
                        _tableCell(e.id),
                        _editableTableCell(e.description, onChanged: (v) {
                          e.description = v;
                          c.premixed.refresh();
                          _checkAndAddPremixedRow();
                        }),
                        _editableTableCell(e.mw, onChanged: (v) {
                          e.mw = v;
                          c.premixed.refresh();
                          _checkAndAddPremixedRow();
                        }),
                        _editableTableCell(e.leasingFee, onChanged: (v) {
                          e.leasingFee = v;
                          c.premixed.refresh();
                          _checkAndAddPremixedRow();
                        }),
                        _editableTableCell(e.mudType, onChanged: (v) {
                          e.mudType = v;
                          c.premixed.refresh();
                          _checkAndAddPremixedRow();
                        }),
                        _checkboxCell(() => e.tax, (v) {
                          e.tax = v;
                          c.premixed.refresh();
                        }),
                      ],
                    );
                  }),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  // ================= OBM =================
  Widget _obmTable() {
    return Container(
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
                Icon(Icons.oil_barrel, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  '8.0 ppg OBM (70/30) with Bar',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryColor.withOpacity(0.1), AppTheme.primaryColor.withOpacity(0.05)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    children: [
                      _tableHeaderCell('#'),
                      _tableHeaderCell('Product'),
                      _tableHeaderCell('Code'),
                      _tableHeaderCell('SG'),
                      _tableHeaderCell('Conc'),
                    ],
                  ),
                  ...c.obm.asMap().entries.map((entry) {
                    final index = entry.key;
                    final e = entry.value;
                    return TableRow(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : AppTheme.cardColor,
                      ),
                      children: [
                        _tableCell(e.id),
                        _editableTableCell(e.product, onChanged: (v) {
                          e.product = v;
                          c.obm.refresh();
                          _checkAndAddObmRow();
                        }),
                        _editableTableCell(e.code, onChanged: (v) {
                          e.code = v;
                          c.obm.refresh();
                          _checkAndAddObmRow();
                        }),
                        _editableTableCell(e.sg, onChanged: (v) {
                          e.sg = v;
                          c.obm.refresh();
                          _checkAndAddObmRow();
                        }),
                        _editableTableCell(e.conc, onChanged: (v) {
                          e.conc = v;
                          c.obm.refresh();
                          _checkAndAddObmRow();
                        }),
                      ],
                    );
                  }),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================
  Widget _headerText(String text, {double? size}) => Text(
    text,
    style: TextStyle(
      fontSize: size ?? 10,
      fontWeight: FontWeight.w600,
      color: AppTheme.textPrimary,
    ),
  );

  Widget _tableHeaderCell(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimary,
      ),
    ),
  );

  Widget _tableCell(String value) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    child: Text(
      value,
      style: TextStyle(
        fontSize: 9,
        color: AppTheme.textPrimary,
      ),
    ),
  );

  Widget _editableTableCell(String value, {Function(String)? onChanged}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    child: Obx(() => c.isLocked.value
        ? Text(
            value,
            style: TextStyle(
              fontSize: 9,
              color: AppTheme.textPrimary,
            ),
          )
        : TextFormField(
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
          )),
  );

  final _cellStyle = TextStyle(
    fontSize: 9,
    color: AppTheme.textPrimary,
  );

  Widget _editableCell(String value, {Function(String)? onChanged}) => Obx(() => c.isLocked.value
      ? Text(value, style: _cellStyle)
      : SizedBox(
          width: double.infinity,
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            style: _cellStyle,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              border: InputBorder.none,
            ),
          ),
        ));

  // ================= ROW FILL CHECKERS =================
  bool _isPremixedRowFilled(PremixModel row) {
    return row.description.isNotEmpty &&
           row.mw.isNotEmpty &&
           row.leasingFee.isNotEmpty &&
           row.mudType.isNotEmpty;
  }

  bool _isObmRowFilled(ObmModel row) {
    return row.product.isNotEmpty &&
           row.code.isNotEmpty &&
           row.sg.isNotEmpty &&
           row.conc.isNotEmpty;
  }

  void _checkAndAddPremixedRow() {
    if (c.premixed.isNotEmpty && _isPremixedRowFilled(c.premixed.last)) {
      int nextId = int.parse(c.premixed.last.id) + 1;
      c.premixed.add(PremixModel(id: nextId.toString(), description: '', mw: '', leasingFee: '', mudType: '', tax: false));
      c.premixed.refresh();
    }
  }

  void _checkAndAddObmRow() {
    if (c.obm.isNotEmpty && _isObmRowFilled(c.obm.last)) {
      int nextId = int.parse(c.obm.last.id) + 1;
      c.obm.add(ObmModel(id: nextId.toString(), product: '', code: '', sg: '', conc: ''));
      c.obm.refresh();
    }
  }

  Widget _checkboxCell(bool Function() getter, Function(bool) onChange) {
    return Center(
      child: Obx(() => Container(
        decoration: BoxDecoration(
          color: getter() ? AppTheme.successColor.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: getter() ? AppTheme.successColor : Colors.grey.shade400,
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Transform.scale(
          scale: 0.75,
          child: Checkbox(
            value: getter(),
            onChanged: c.isLocked.value ? null : (v) => onChange(v!),
            activeColor: AppTheme.successColor,
            checkColor: Colors.white,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      )),
    );
  }
}
