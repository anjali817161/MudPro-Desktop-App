import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/operation_controller.dart';
import '../../controller/dashboard_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ConsumeServicesView extends StatelessWidget {
  ConsumeServicesView({super.key});

  final dashboardController = Get.find<DashboardController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= ENHANCED HEADER =================
              // _buildHeader(),
              // const SizedBox(height: 24),

              /// ================= PACKAGE TABLE =================
              _buildAdvancedTableCard(
                title: "Package",
                icon: Icons.inventory_2_rounded,
                headers: [
                  "Package",
                  "Code",
                  "Unit",
                  "Price (\$)",
                  "Initial",
                  "Used",
                  "Final",
                  "Cost (\$)",
                ],
                color: AppTheme.primaryColor,
                rowCount: 15,
              ),

              const SizedBox(height: 24),

              /// ================= SERVICES TABLE =================
              _buildAdvancedTableCard(
                title: "Services",
                icon: Icons.build_circle_rounded,
                headers: [
                  "Services",
                  "Code",
                  "Unit",
                  "Price (\$)",
                  "Usage",
                  "Cost (\$)",
                ],
                color: AppTheme.successColor,
                rowCount: 12,
              ),

              const SizedBox(height: 24),

              /// ================= ENGINEERING TABLE =================
              _buildAdvancedTableCard(
                title: "Engineering",
                icon: Icons.engineering_rounded,
                headers: [
                  "Engineering",
                  "Code",
                  "Unit",
                  "Price (\$)",
                  "Usage",
                  "Cost (\$)",
                ],
                color: AppTheme.infoColor,
                rowCount: 10,
              ),

              /// ================= FOOTER SUMMARY =================
              const SizedBox(height: 24),
              _buildFooterSummary(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------- ENHANCED HEADER -----------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.9),
            AppTheme.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_checkout_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consume Services",
                        style: AppTheme.titleMedium.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Track and manage service consumption",
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Total Estimated Cost",
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "\$45,280.50",
                  style: AppTheme.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------- ADVANCED TABLE CARD -----------------
  Widget _buildAdvancedTableCard({
    required String title,
    required IconData icon,
    required List<String> headers,
    required Color color,
    required int rowCount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TABLE HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "$rowCount Items",
                    style: AppTheme.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// SCROLLABLE TABLE CONTENT
          SizedBox(
            height: 380, // Increased height
            child: Scrollbar(
              thumbVisibility: true,
              controller: ScrollController(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Obx(() => Table(
                    defaultColumnWidth: const FixedColumnWidth(140),
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    columnWidths: _generateColumnWidths(headers.length),
                    children: [
                      /// ENHANCED HEADER ROW
                      TableRow(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.08),
                        ),
                        children: headers.map((header) {
                          return _buildEnhancedHeaderCell(header);
                        }).toList(),
                      ),

                      /// DATA ROWS
                      ...List.generate(rowCount, (rowIndex) {
                        return TableRow(
                          decoration: BoxDecoration(
                            color: rowIndex % 2 == 0 
                                ? Colors.white 
                                : Colors.grey.shade50,
                          ),
                          children: headers.asMap().entries.map((entry) {
                            final columnIndex = entry.key;
                            return _buildEnhancedDataCell(
                              rowIndex: rowIndex,
                              columnIndex: columnIndex,
                              totalColumns: headers.length,
                              isEditable: !dashboardController.isLocked.value,
                              color: color,
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  )),
                ),
              ),
            ),
          ),

          /// TABLE FOOTER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing $rowCount entries",
                  style: AppTheme.caption.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      splashRadius: 20,
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == 0 ? color : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: index == 0 ? color : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          (index + 1).toString(),
                          style: AppTheme.caption.copyWith(
                            color: index == 0 ? Colors.white : AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      splashRadius: 20,
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

  // ----------------- ENHANCED HEADER CELL -----------------
  Widget _buildEnhancedHeaderCell(String text) {
    final isPriceColumn = text.contains('\$');
    
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: isPriceColumn ? Alignment.centerRight : Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: Text(
        text,
        style: AppTheme.bodySmall.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.textPrimary,
          letterSpacing: 0.3,
        ),
        textAlign: isPriceColumn ? TextAlign.right : TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ----------------- ENHANCED DATA CELL -----------------
  Widget _buildEnhancedDataCell({
    required int rowIndex,
    required int columnIndex,
    required int totalColumns,
    required bool isEditable,
    required Color color,
  }) {
    final sampleData = _generateSampleData(rowIndex, columnIndex, totalColumns);
    final isPriceColumn = sampleData.contains('\$') || columnIndex >= totalColumns - 2;
    final isFirstColumn = columnIndex == 0;
    
    return Container(
      height: 56, // Increased cell height
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: isPriceColumn ? Alignment.centerRight : Alignment.centerLeft,
      child: isEditable && columnIndex > 0
          ? TextField(
              controller: TextEditingController(text: sampleData),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: "Enter value...",
                hintStyle: AppTheme.bodySmall.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 11,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              style: AppTheme.bodySmall.copyWith(
                fontSize: 12,
                color: AppTheme.textPrimary,
                fontWeight: isPriceColumn ? FontWeight.w500 : FontWeight.w400,
              ),
              textAlign: isPriceColumn ? TextAlign.right : TextAlign.left,
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                sampleData,
                style: AppTheme.bodySmall.copyWith(
                  fontSize: 12,
                  color: isFirstColumn ? color : AppTheme.textPrimary,
                  fontWeight: isFirstColumn ? FontWeight.w600 : 
                            isPriceColumn ? FontWeight.w500 : FontWeight.w400,
                ),
                textAlign: isPriceColumn ? TextAlign.right : TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
    );
  }

  // ----------------- FOOTER SUMMARY -----------------
  Widget _buildFooterSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSummaryItem(
            icon: Icons.summarize_rounded,
            title: "Total Records",
            value: "37 Items",
            color: AppTheme.successColor,
          ),
          _buildSummaryItem(
            icon: Icons.monetization_on_rounded,
            title: "Package Cost",
            value: "\$24,750.00",
            color: AppTheme.primaryColor,
          ),
          _buildSummaryItem(
            icon: Icons.handyman_rounded,
            title: "Services Cost",
            value: "\$10,200.00",
            color: AppTheme.successColor,
          ),
          _buildSummaryItem(
            icon: Icons.engineering_rounded,
            title: "Engineering Cost",
            value: "\$10,330.50",
            color: AppTheme.infoColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Grand Total",
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$45,280.50",
                  style: AppTheme.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------- SUMMARY ITEM -----------------
  Widget _buildSummaryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 16,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTheme.caption.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ----------------- HELPER: GENERATE SAMPLE DATA -----------------
  String _generateSampleData(int rowIndex, int columnIndex, int totalColumns) {
    final packages = [
      "Basic Package", "Premium Package", "Standard Package", "Enterprise Package",
      "Starter Kit", "Professional Suite", "Ultimate Bundle", "Custom Package"
    ];
    
    final services = [
      "Standard Service", "Premium Service", "24/7 Support", "Maintenance",
      "Consulting", "Training", "Implementation", "Custom Development"
    ];
    
    final engineering = [
      "Engineering Service", "Technical Support", "System Design", "Architecture",
      "Development", "Testing", "Deployment", "Optimization"
    ];
    
    if (columnIndex == 0) {
      if (totalColumns == 8) {
        return packages[rowIndex % packages.length];
      } else if (rowIndex < 8) {
        return services[rowIndex % services.length];
      } else {
        return engineering[rowIndex % engineering.length];
      }
    } else if (columnIndex == 1) {
      final prefix = totalColumns == 8 ? "PKG-" : 
                    rowIndex < 8 ? "SRV-" : "ENG-";
      return "$prefix${(rowIndex + 1).toString().padLeft(3, '0')}";
    } else if (columnIndex == 2) {
      final units = ["Pcs", "Hrs", "Days", "Units"];
      return units[rowIndex % units.length];
    } else if (columnIndex == 3) {
      final price = (100 + (rowIndex * 50) + (columnIndex * 10)).toDouble();
      return "\$${price.toStringAsFixed(2)}";
    } else if (columnIndex == totalColumns - 1) {
      final cost = (1000 + (rowIndex * 200) + (columnIndex * 50)).toDouble();
      return "\$${cost.toStringAsFixed(2)}";
    } else {
      final value = (10 + (rowIndex * 5) + columnIndex).toString();
      return value;
    }
  }

  // ----------------- HELPER: GENERATE COLUMN WIDTHS -----------------
  Map<int, TableColumnWidth> _generateColumnWidths(int columnCount) {
    final Map<int, TableColumnWidth> widths = {};
    
    for (int i = 0; i < columnCount; i++) {
      if (i == 0) {
        widths[i] = const FixedColumnWidth(160); // Name column
      } else if (i == 1) {
        widths[i] = const FixedColumnWidth(100); // Code column
      } else if (i == 2) {
        widths[i] = const FixedColumnWidth(80); // Unit column
      } else if (i == columnCount - 1) {
        widths[i] = const FixedColumnWidth(120); // Cost column
      } else {
        widths[i] = const FixedColumnWidth(110); // Other columns
      }
    }
    
    return widths;
  }
}