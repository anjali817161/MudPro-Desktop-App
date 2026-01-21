import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/operators_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

/// =======================================================
/// OPERATOR TAB (COMPRESSED & EXCEL-LIKE UI)
/// =======================================================
class OperatorTab extends StatefulWidget {
  const OperatorTab({super.key});

  @override
  State<OperatorTab> createState() => _OperatorTabState();
}

class _OperatorTabState extends State<OperatorTab> {
  int selectedRow = -1;
  final ScrollController _scrollController = ScrollController();
  final controller = Get.put(OperatorController());

  // Start with 1 row, will grow dynamically
  List<List<TextEditingController>> controllers = [
    List.generate(6, (_) => TextEditingController()),
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to detect when user types in last row
    _addListenersToRow(0);
  }

  void _addListenersToRow(int rowIndex) {
    for (var controller in controllers[rowIndex]) {
      controller.addListener(() {
        _checkAndAddNewRow(rowIndex);
      });
    }
  }

  void _checkAndAddNewRow(int rowIndex) {
    // If user types in the last row and it's not empty, add a new row
    if (rowIndex == controllers.length - 1) {
      bool hasData = controllers[rowIndex].any((c) => c.text.isNotEmpty);
      if (hasData && controllers.length < 100) {
        setState(() {
          controllers.add(List.generate(6, (_) => TextEditingController()));
          _addListenersToRow(controllers.length - 1);
        });
      }
    }
  }

  void _clearRowsAfterSave() {
    // Clear all rows and reset to 1 empty row
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    setState(() {
      controllers = [
        List.generate(6, (_) => TextEditingController()),
      ];
      selectedRow = -1;
      _addListenersToRow(0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compact Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppTheme.secondaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business_center,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Operator',
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Compact Table Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Compact Table Header
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        _HeaderCell(width: 45, text: '#', icon: Icons.numbers),
                        _HeaderCell(width: 180, text: 'Company', icon: Icons.business),
                        _HeaderCell(width: 180, text: 'Contact', icon: Icons.person),
                        _HeaderCell(width: 200, text: 'Address', icon: Icons.location_on),
                        _HeaderCell(width: 160, text: 'Phone', icon: Icons.phone),
                        _HeaderCell(width: 200, text: 'E-mail', icon: Icons.email),
                        _HeaderCell(width: 120, text: 'Logo', icon: Icons.image, isLast: true),
                      ],
                    ),
                  ),

                  // Compact Table Body
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: controllers.length,
                        itemBuilder: (context, row) {
                          final bool isSelected = row == selectedRow;

                          return Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryColor.withOpacity(0.08)
                                  : row % 2 == 0
                                      ? Colors.white
                                      : AppTheme.cardColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => setState(() {
                                  selectedRow = row;
                                }),
                                hoverColor: AppTheme.primaryColor.withOpacity(0.04),
                                child: Row(
                                  children: [
                                    // Compact Number Column
                                    Container(
                                      width: 45,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected
                                                ? AppTheme.accentColor
                                                : AppTheme.secondaryColor.withOpacity(0.15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${row + 1}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: isSelected
                                                    ? Colors.white
                                                    : AppTheme.textPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Data Cells
                                    _cell(180, controllers[row][0], ''),
                                    _cell(180, controllers[row][1], ''),
                                    _cell(200, controllers[row][2], ''),
                                    _cell(160, controllers[row][3], ''),
                                    _cell(200, controllers[row][4], ''),
                                    _cell(120, controllers[row][5], '', isLast: true),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Compact Footer
          Container(
            height: 44,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppTheme.infoColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${controllers.length} row(s) • Selected: ${selectedRow == -1 ? 'None' : 'Row ${selectedRow + 1}'}',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.errorColor),
                        foregroundColor: AppTheme.errorColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        minimumSize: const Size(0, 32),
                      ),
                      icon: const Icon(Icons.close, size: 14),
                      label: const Text('Close', style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        if (selectedRow != -1) {
                          for (var controller in controllers[selectedRow]) {
                            controller.clear();
                          }
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.warningColor),
                        foregroundColor: AppTheme.warningColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        minimumSize: const Size(0, 32),
                      ),
                      icon: const Icon(Icons.delete_outline, size: 14),
                      label: const Text('Clear', style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await controller.saveOperators(controllers);
                        _clearRowsAfterSave();
                      },
                      style: AppTheme.primaryButtonStyle.copyWith(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(0, 32)),
                      ),
                      icon: const Icon(Icons.save, size: 14),
                      label: const Text('Save', style: TextStyle(fontSize: 12)),
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

  Widget _cell(double width, TextEditingController controller, String hintText,
      {bool isLast = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border(
          right: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade400, width: 1),
        ),
      ),
      child: TextField(
        controller: controller,
        style: AppTheme.bodyLarge.copyWith(fontSize: 12),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary.withOpacity(0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        ),
      ),
    );
  }
}

/// =======================================================
/// HEADER CELL WIDGET (COMPACT VERSION)
/// =======================================================
class _HeaderCell extends StatelessWidget {
  final double width;
  final String text;
  final IconData icon;
  final bool isLast;

  const _HeaderCell({
    required this.width,
    required this.text,
    required this.icon,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                right: BorderSide(
                  color: AppTheme.textPrimary.withOpacity(0.3),
                  width: 1,
                ),
              ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}