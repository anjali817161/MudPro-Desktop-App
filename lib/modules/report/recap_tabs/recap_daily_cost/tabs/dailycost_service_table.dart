import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/report/recap_tabs/controller/service_dailycost_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';


class ServiceRecapPage extends StatelessWidget {
  final controller = Get.put(ServiceRecapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            decoration: AppTheme.cardDecoration,
            child: Column(
              children: [
                _buildTableHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                          children: List.generate(
                            controller.entries.length,
                            (index) => _buildTableRow(index, context),
                          ),
                        )),
                  ),
                ),
                _buildTotalRow(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addEntry(),
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildHeaderCell('', flex: 1),
            _buildHeaderCell('Date', flex: 3),
            _buildHeaderCell('Rpt. #', flex: 2),
            _buildHeaderCell('MD\n(ft)', flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTheme.titleMedium.copyWith(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(int index, BuildContext context) {
    final entry = controller.entries[index];
    final isEven = index % 2 == 0;

    return Container(
      decoration: BoxDecoration(
        color: isEven ? Colors.white : AppTheme.cardColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE2E8F0),
            width: 0.5,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildIndexCell(index + 1),
            _buildEditableCell(
              entry.date,
              flex: 3,
              onChanged: (value) =>
                  controller.updateEntry(index, 'date', value),
            ),
            _buildEditableCell(
              entry.rpt.toString(),
              flex: 2,
              onChanged: (value) =>
                  controller.updateEntry(index, 'rpt', value),
              keyboardType: TextInputType.number,
            ),
            _buildEditableCell(
              entry.md.toStringAsFixed(1),
              flex: 2,
              onChanged: (value) =>
                  controller.updateEntry(index, 'md', value),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexCell(int index) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          index.toString(),
          textAlign: TextAlign.center,
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildEditableCell(
    String value, {
    required int flex,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          textAlign: TextAlign.center,
          style: AppTheme.bodyLarge,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDeleteCell(int index) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: IconButton(
          icon: Icon(Icons.delete_outline, size: 18),
          color: AppTheme.errorColor,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () => controller.removeEntry(index),
        ),
      ),
    );
  }

  Widget _buildTotalRow() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade200, width: 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade200, width: 0.5),
                  ),
                ),
                child: Text(
                  'Total (€)',
                  textAlign: TextAlign.center,
                  style: AppTheme.titleMedium.copyWith(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade200, width: 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade200, width: 0.5),
                    ),
                  ),
                  child: Text(
                    controller.totalMd.toStringAsFixed(1),
                    textAlign: TextAlign.center,
                    style: AppTheme.titleMedium.copyWith(
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

