import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/ug_pit_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import '../../controller/dashboard_controller.dart';

class SwitchPitView extends StatefulWidget {
  const SwitchPitView({super.key});

  @override
  State<SwitchPitView> createState() => _SwitchPitViewState();
}

class _SwitchPitViewState extends State<SwitchPitView> {
  final PitController pitController = Get.put(PitController());
  final DashboardController dashboardController = Get.find<DashboardController>();

  final ScrollController activePitScrollController = ScrollController();
  final ScrollController storagePitScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await pitController.fetchSelectedPits();
    await pitController.fetchUnselectedPits();
  }

  @override
  void dispose() {
    activePitScrollController.dispose();
    storagePitScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active Pits Section
          _buildActivePitsSection(),
          const SizedBox(height: 30),
          // Storage Pits Section
          _buildStoragePitsSection(),
        ],
      ),
    );
  }

  // ===================================================
  // ACTIVE PITS SECTION
  // ===================================================
  Widget _buildActivePitsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Active Pits - Uncheck to Move to Storage",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Table
          _buildActivePitsTable(),
        ],
      ),
    );
  }

  // ===================================================
  // STORAGE PITS SECTION
  // ===================================================
  Widget _buildStoragePitsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              "Storage - Uncheck to Move to Active Pits",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),

          // Table
          _buildStoragePitsTable(),
        ],
      ),
    );
  }

  // ===================================================
  // ACTIVE PITS TABLE (4 COLUMNS)
  // ===================================================
  Widget _buildActivePitsTable() {
    return Column(
      children: [
        // Fixed Header
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.6), // #
              1: FlexColumnWidth(2.0), // Pit
              2: FlexColumnWidth(1.0), // Checked
              3: FlexColumnWidth(1.5), // Measured Vol.
            },
            children: [
              TableRow(
                children: [
                  _buildHeaderCell("#"),
                  _buildHeaderCell("Pit"),
                  _buildHeaderCell("Checked"),
                  _buildHeaderCell("Measured Vol. (bbl)"),
                ],
              ),
            ],
          ),
        ),

        // Scrollable Body
        Obx(() {
          if (pitController.isLoading.value) {
            return Container(
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          if (pitController.selectedPits.isEmpty) {
            return Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                "No active pits",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            );
          }

          return Container(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Scrollbar(
              controller: activePitScrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: activePitScrollController,
                shrinkWrap: true,
                itemCount: pitController.selectedPits.length,
                itemBuilder: (context, index) {
                  final pit = pitController.selectedPits[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.white : Colors.grey.shade50,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.6),
                        1: FlexColumnWidth(2.0),
                        2: FlexColumnWidth(1.0),
                        3: FlexColumnWidth(1.5),
                      },
                      children: [
                        TableRow(
                          children: [
                            _buildDataCell("${index + 1}"),
                            _buildDataCell(pit.pitName, isLeft: true),
                            _buildCheckboxCell(pit, true),
                            _buildDataCell(pit.capacity.value.toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  // ===================================================
  // STORAGE PITS TABLE (3 COLUMNS)
  // ===================================================
  Widget _buildStoragePitsTable() {
    return Column(
      children: [
        // Fixed Header
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.6), // #
              1: FlexColumnWidth(2.5), // Pit
              2: FlexColumnWidth(1.0), // Checked
            },
            children: [
              TableRow(
                children: [
                  _buildHeaderCell("#"),
                  _buildHeaderCell("Pit"),
                  _buildHeaderCell("Checked"),
                ],
              ),
            ],
          ),
        ),

        // Scrollable Body
        Obx(() {
          if (pitController.isLoading.value) {
            return Container(
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          if (pitController.unselectedPits.isEmpty) {
            return Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                "No storage pits",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            );
          }

          return Container(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Scrollbar(
              controller: storagePitScrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: storagePitScrollController,
                shrinkWrap: true,
                itemCount: pitController.unselectedPits.length,
                itemBuilder: (context, index) {
                  final pit = pitController.unselectedPits[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.white : Colors.grey.shade50,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.6),
                        1: FlexColumnWidth(2.5),
                        2: FlexColumnWidth(1.0),
                      },
                      children: [
                        TableRow(
                          children: [
                            _buildDataCell("${index + 1}"),
                            _buildDataCell(pit.pitName, isLeft: true),
                            _buildCheckboxCell(pit, false),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  // ===================================================
  // HELPER WIDGETS
  // ===================================================
  
  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
        textAlign: text == "#" || text == "Checked" ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  Widget _buildDataCell(String text, {bool isLeft = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppTheme.textPrimary,
        ),
        textAlign: isLeft ? TextAlign.left : TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCheckboxCell(dynamic pit, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      alignment: Alignment.center,
      child: Obx(() {
        // For active pits: checkbox is checked when initialActive is true
        // For storage pits: checkbox is checked when initialActive is false (inverted)
        bool checkboxValue = isActive ? pit.initialActive.value : !pit.initialActive.value;
        
        return Transform.scale(
          scale: 1.0,
          child: Checkbox(
            value: checkboxValue,
            onChanged: dashboardController.isLocked.value
                ? null
                : (v) async {
                    // Toggle the pit status
                    await pitController.togglePitActive(pit);
                    
                    // Reload data to reflect changes
                    await _loadData();
                  },
            activeColor: AppTheme.primaryColor,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        );
      }),
    );
  }
}