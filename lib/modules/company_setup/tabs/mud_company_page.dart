import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class MudCompanyPage extends StatefulWidget {
  const MudCompanyPage({super.key});

  @override
  State<MudCompanyPage> createState() => _MudCompanyPageState();
}

class _MudCompanyPageState extends State<MudCompanyPage> {
  static const int totalRows = 100;

  final List<TextEditingController> leftControllers =
      List.generate(5, (_) => TextEditingController());

  String currencySymbol = '₹';
  String currencyFormat = '0.00';
  String? logoImagePath;

  final List<List<TextEditingController>> rightControllers =
      List.generate(totalRows, (_) {
    return List.generate(6, (_) => TextEditingController());
  });

  // Add ScrollController for the right table
  final ScrollController _tableScrollController = ScrollController();

  @override
  void dispose() {
    _tableScrollController.dispose();
    for (var row in rightControllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    for (var controller in leftControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _leftSection(),
            const SizedBox(width: 12),
            Expanded(child: _rightSection()),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // LEFT SECTION
  // ======================================================
  Widget _leftSection() {
    return Container(
      width: 360,
      decoration: AppTheme.elevatedCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Mud Company Settings',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          // Content - Fixed: Use SingleChildScrollView with proper controller
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Company Information'),
                  const SizedBox(height: 8),
                  _twoColumnRow('Company Name', leftControllers[0], Icons.business),
                  const SizedBox(height: 6),
                  _twoColumnRow('Address', leftControllers[1], Icons.location_on),
                  const SizedBox(height: 6),
                  _twoColumnRow('Phone', leftControllers[2], Icons.phone),
                  const SizedBox(height: 6),
                  _twoColumnRow('E-mail', leftControllers[3], Icons.email),
                  
                  const SizedBox(height: 20),
                  
                  // Logo Upload Section
                  _sectionTitle('Company Logo'),
                  const SizedBox(height: 8),
                  _logoUploadSection(),
                  
                  const SizedBox(height: 20),
                  
                  _sectionTitle('Currency Settings'),
                  const SizedBox(height: 8),
                  _currencyRow(),
                  const SizedBox(height: 6),
                  _currencyFormatRow(),
                  
                  // Add some bottom padding
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _twoColumnRow(String label, TextEditingController controller, IconData icon) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.cardColor,
                  AppTheme.cardColor.withOpacity(0.9),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: controller,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Enter $label...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoUploadSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        children: [
          // Logo Preview
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Center(
              child: logoImagePath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: AppTheme.textSecondary.withOpacity(0.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No Logo Selected',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset(
                          logoImagePath!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 40,
                              color: AppTheme.errorColor,
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ),
          
          // Upload Controls
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: leftControllers[4],
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textPrimary,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Enter logo URL or path...',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      logoImagePath = leftControllers[4].text.isNotEmpty 
                          ? leftControllers[4].text 
                          : 'assets/logo.png';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(60, 26),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  icon: const Icon(Icons.upload, size: 12),
                  label: const Text('Upload', style: TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _currencyRow() {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.cardColor,
                  AppTheme.cardColor.withOpacity(0.9),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.currency_exchange,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Symbol',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currencySymbol,
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: AppTheme.primaryColor,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textPrimary,
                  ),
                  onChanged: (v) => setState(() => currencySymbol = v!),
                  items: const ['₹', '\$', '€', '£', '¥', '₩']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  

  Widget _currencyFormatRow() {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.cardColor,
                  AppTheme.cardColor.withOpacity(0.9),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Format',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currencyFormat,
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: AppTheme.primaryColor,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textPrimary,
                  ),
                  onChanged: (v) => setState(() => currencyFormat = v!),
                  items: const ['0', '0.0', '0.00', '0.000', '0.0000']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // RIGHT SECTION
  // ======================================================
  Widget _rightSection() {
    return Container(
      decoration: AppTheme.elevatedCardDecoration,
      child: Column(
        children: [
          // Header
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                _HeaderCell(40, '#', Icons.numbers),
                _HeaderCell(140, 'First Name', Icons.person),
                _HeaderCell(140, 'Last Name', Icons.person_outline),
                _HeaderCell(120, 'Cell', Icons.phone_android),
                _HeaderCell(120, 'Office', Icons.phone),
                _HeaderCell(200, 'E-mail', Icons.email),
                _HeaderCell(100, 'Photo', Icons.camera_alt),
              ],
            ),
          ),
          
          // Table - Fixed: Using the same ScrollController for Scrollbar and ListView
          Expanded(
            child: Scrollbar(
              controller: _tableScrollController,
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView.builder(
                controller: _tableScrollController,
                itemCount: totalRows,
                itemBuilder: (_, row) {
                  return Container(
                    height: 30, // Increased from 26 to 30 for better visibility
                    decoration: BoxDecoration(
                      color: row % 2 == 0 ? Colors.white : AppTheme.cardColor,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          _numberCell(row + 1),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(140, rightControllers[row][0], ''),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(140, rightControllers[row][1], ''),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(120, rightControllers[row][2], ''),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(120, rightControllers[row][3], ''),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(200, rightControllers[row][4], ''),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          _editableCell(100, rightControllers[row][5], ''),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Footer
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppTheme.infoColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$totalRows contacts • Mud Company Directory',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: AppTheme.primaryButtonStyle.copyWith(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(0, 32)),
                  ),
                  icon: const Icon(Icons.save, size: 14),
                  label: const Text('Save All', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberCell(int number) {
    return SizedBox(
      width: 40,
      child: Center(
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.secondaryGradient,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _editableCell(double width, TextEditingController controller, String hint) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final double width;
  final String text;
  final IconData icon;

  const _HeaderCell(this.width, this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
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
                letterSpacing: 0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}