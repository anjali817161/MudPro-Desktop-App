import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/auth_repo/auth_repo.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/service_controller.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  static const int rowCount = 20;
  final ServiceController controller = ServiceController();
  bool _isLoading = false;

  final List<List<TextEditingController>> packageControllers = _generateControllers();
  final List<List<TextEditingController>> servicesControllers = _generateControllers();
  final List<List<TextEditingController>> engineeringControllers = _generateControllers();

  static List<List<TextEditingController>> _generateControllers() {
    return List.generate(
      rowCount,
      (_) => List.generate(4, (_) => TextEditingController()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);
    try {
      await Future.wait([
        _loadPackages(),
        _loadServices(),
        _loadEngineering(),
      ]);
    } catch (e) {
      _showError('Failed to load data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadPackages() async {
    try {
      final packages = await controller.getPackages();
      for (int i = 0; i < packages.length && i < rowCount; i++) {
        packageControllers[i][0].text = packages[i].name;
        packageControllers[i][1].text = packages[i].code;
        packageControllers[i][2].text = packages[i].unit;
        packageControllers[i][3].text = packages[i].price.toString();
      }
    } catch (e) {
      print('Error loading packages: $e');
    }
  }

  Future<void> _loadServices() async {
    try {
      final services = await controller.getServices();
      for (int i = 0; i < services.length && i < rowCount; i++) {
        servicesControllers[i][0].text = services[i].name;
        servicesControllers[i][1].text = services[i].code;
        servicesControllers[i][2].text = services[i].unit;
        servicesControllers[i][3].text = services[i].price.toString();
      }
    } catch (e) {
      print('Error loading services: $e');
    }
  }

  Future<void> _loadEngineering() async {
    try {
      final engineering = await controller.getEngineering();
      for (int i = 0; i < engineering.length && i < rowCount; i++) {
        engineeringControllers[i][0].text = engineering[i].name;
        engineeringControllers[i][1].text = engineering[i].code;
        engineeringControllers[i][2].text = engineering[i].unit;
        engineeringControllers[i][3].text = engineering[i].price.toString();
      }
    } catch (e) {
      print('Error loading engineering: $e');
    }
  }

  Future<void> _savePackages() async {
    setState(() => _isLoading = true);
    try {
      List<PackageItem> packages = [];
      for (var row in packageControllers) {
        if (row[0].text.trim().isNotEmpty) {
          packages.add(PackageItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }
      
      if (packages.isEmpty) {
        _showError('Please add at least one package');
        return;
      }

      await controller.addPackages(packages);
      _showSuccess('Packages saved successfully!');
      for (var row in packageControllers) {
        for (var controller in row) {
          controller.clear();
        }
      }
    } catch (e) {
      _showError('Failed to save packages: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveServices() async {
    setState(() => _isLoading = true);
    try {
      List<ServiceItem> services = [];
      for (var row in servicesControllers) {
        if (row[0].text.trim().isNotEmpty) {
          services.add(ServiceItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }
      
      if (services.isEmpty) {
        _showError('Please add at least one service');
        return;
      }

      await controller.addServices(services);
      _showSuccess('Services saved successfully!');
      for (var row in servicesControllers) {
        for (var controller in row) {
          controller.clear();
        }
      }
    } catch (e) {
      _showError('Failed to save services: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveEngineering() async {
    setState(() => _isLoading = true);
    try {
      List<EngineeringItem> engineering = [];
      for (var row in engineeringControllers) {
        if (row[0].text.trim().isNotEmpty) {
          engineering.add(EngineeringItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }
      
      if (engineering.isEmpty) {
        _showError('Please add at least one engineering item');
        return;
      }

      await controller.addEngineering(engineering);
      _showSuccess('Engineering items saved successfully!');
      for (var row in engineeringControllers) {
        for (var controller in row) {
          controller.clear();
        }
      }
    } catch (e) {
      _showError('Failed to save engineering: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSuccess(String message) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 300,
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    for (var table in [packageControllers, servicesControllers, engineeringControllers]) {
      for (var row in table) {
        for (var controller in row) {
          controller.dispose();
        }
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 1200) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildTableSections(constraints),
                          ),
                        );
                      } else {
                        return Row(
                          children: _buildTableSections(constraints),
                        );
                      }
                    },
                  ),
                ),
                _footerButtons(),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTableSections(BoxConstraints constraints) {
    return [
      _tableSection(
        title: 'Package',
        controllers: packageControllers,
        icon: Icons.inventory,
        gradient: AppTheme.primaryGradient,
        constraints: constraints,
        onSave: _savePackages,
      ),
      const SizedBox(width: 12),
      _tableSection(
        title: 'Services',
        controllers: servicesControllers,
        icon: Icons.miscellaneous_services,
        gradient: AppTheme.secondaryGradient,
        constraints: constraints,
        onSave: _saveServices,
      ),
      const SizedBox(width: 12),
      _tableSection(
        title: 'Engineering',
        controllers: engineeringControllers,
        icon: Icons.engineering,
        gradient: AppTheme.accentGradient,
        constraints: constraints,
        onSave: _saveEngineering,
      ),
    ];
  }

  Widget _tableSection({
    required String title,
    required List<List<TextEditingController>> controllers,
    required IconData icon,
    required Gradient gradient,
    required BoxConstraints constraints,
    required VoidCallback onSave,
  }) {
    final isSmallScreen = constraints.maxWidth < 400;
    final widths = isSmallScreen
        ? [25.0, 100.0, 50.0, 40.0, 50.0]
        : [35.0, 150.0, 75.0, 65.0, 75.0];

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            _sectionHeader(title, icon, gradient),
            _tableHeader(widths),
            Container(height: 1, color: Colors.grey.shade300),
            Expanded(child: _tableRows(controllers, widths)),
            _tableSaveButton(onSave, title),
          ],
        ),
      ),
    );
  }

  Widget _tableSaveButton(VoidCallback onSave, String title) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _isLoading ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            'Save $title',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Gradient gradient) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(List<double> widths) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.tableHeadColor.withOpacity(0.9),
            AppTheme.tableHeadColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          _HeaderCell(width: widths[0], text: '', icon: Icons.numbers),
          _HeaderCell(width: widths[1], text: 'Name', icon: Icons.text_fields),
          _HeaderCell(width: widths[2], text: 'Code', icon: Icons.code),
          _HeaderCell(width: widths[3], text: 'Unit', icon: Icons.linear_scale),
          Expanded(child: _HeaderCell(text: 'Price (\$)', icon: Icons.attach_money)),
        ],
      ),
    );
  }

  Widget _tableRows(List<List<TextEditingController>> controllers, List<double> widths) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemCount: rowCount,
        itemBuilder: (_, row) {
          return Container(
            height: 28,
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
                  _numberCell(row, widths[0]),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  _editCell(widths[1], controllers[row][0]),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  _editCell(widths[2], controllers[row][1]),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  _editCell(widths[3], controllers[row][2]),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  _editCell(widths[4], controllers[row][3]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _numberCell(int row, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.secondaryColor.withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              '${row + 1}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _editCell(double width, TextEditingController controller) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 11, color: AppTheme.textPrimary),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _footerButtons() {
    return Container(
      height: 52,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppTheme.errorColor),
              foregroundColor: AppTheme.errorColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final double? width;
  final String text;
  final IconData icon;

  const _HeaderCell({this.width, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}