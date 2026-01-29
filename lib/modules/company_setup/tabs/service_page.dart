import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/service_controller.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ServiceController controller = ServiceController();
  bool _isLoading = false;

  List<PackageItem> existingPackages = [];
  List<ServiceItem> existingServices = [];
  List<EngineeringItem> existingEngineering = [];

  final List<List<TextEditingController>> packageControllers = _generateControllers();
  final List<List<TextEditingController>> servicesControllers = _generateControllers();
  final List<List<TextEditingController>> engineeringControllers = _generateControllers();

  // ScrollControllers for each table
  final ScrollController _packageScrollController = ScrollController();
  final ScrollController _servicesScrollController = ScrollController();
  final ScrollController _engineeringScrollController = ScrollController();

  static List<List<TextEditingController>> _generateControllers() {
    return List.generate(5, (_) => List.generate(4, (_) => TextEditingController()));
  }

  @override
  void initState() {
    super.initState();
    _loadAllData();
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
      existingPackages = await controller.getPackages();
      setState(() {});
    } catch (e) {
      print('Error loading packages: $e');
    }
  }

  Future<void> _loadServices() async {
    try {
      existingServices = await controller.getServices();
      setState(() {});
    } catch (e) {
      print('Error loading services: $e');
    }
  }

  Future<void> _loadEngineering() async {
    try {
      existingEngineering = await controller.getEngineering();
      setState(() {});
    } catch (e) {
      print('Error loading engineering: $e');
    }
  }

  // Update Package
  Future<void> _showUpdatePackageDialog(PackageItem package, int index) async {
    final nameController = TextEditingController(text: package.name);
    final codeController = TextEditingController(text: package.code);
    final unitController = TextEditingController(text: package.unit);
    final priceController = TextEditingController(text: package.price.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Package'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _updatePackage(
                package.id!,
                PackageItem(
                  id: package.id,
                  name: nameController.text.trim(),
                  code: codeController.text.trim(),
                  unit: unitController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0.0,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _updatePackage(String id, PackageItem package) async {
    setState(() => _isLoading = true);
    try {
      final result = await controller.updatePackage(id, package);
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Package updated successfully!');
        await _loadPackages();
      } else {
        _showError(result['message'] ?? 'Failed to update package');
      }
    } catch (e) {
      _showError('Failed to update package: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deletePackage(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this package?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        final result = await controller.deletePackage(id);
        if (result['success'] == true) {
          _showSuccess(result['message'] ?? 'Package deleted successfully!');
          await _loadPackages();
        } else {
          _showError(result['message'] ?? 'Failed to delete package');
        }
      } catch (e) {
        _showError('Failed to delete package: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  // Update Service
  Future<void> _showUpdateServiceDialog(ServiceItem service, int index) async {
    final nameController = TextEditingController(text: service.name);
    final codeController = TextEditingController(text: service.code);
    final unitController = TextEditingController(text: service.unit);
    final priceController = TextEditingController(text: service.price.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Service'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _updateService(
                service.id!,
                ServiceItem(
                  id: service.id,
                  name: nameController.text.trim(),
                  code: codeController.text.trim(),
                  unit: unitController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0.0,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateService(String id, ServiceItem service) async {
    setState(() => _isLoading = true);
    try {
      final result = await controller.updateService(id, service);
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Service updated successfully!');
        await _loadServices();
      } else {
        _showError(result['message'] ?? 'Failed to update service');
      }
    } catch (e) {
      _showError('Failed to update service: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteService(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this service?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        final result = await controller.deleteService(id);
        if (result['success'] == true) {
          _showSuccess(result['message'] ?? 'Service deleted successfully!');
          await _loadServices();
        } else {
          _showError(result['message'] ?? 'Failed to delete service');
        }
      } catch (e) {
        _showError('Failed to delete service: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  // Update Engineering
  Future<void> _showUpdateEngineeringDialog(EngineeringItem engineering, int index) async {
    final nameController = TextEditingController(text: engineering.name);
    final codeController = TextEditingController(text: engineering.code);
    final unitController = TextEditingController(text: engineering.unit);
    final priceController = TextEditingController(text: engineering.price.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Engineering'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _updateEngineering(
                engineering.id!,
                EngineeringItem(
                  id: engineering.id,
                  name: nameController.text.trim(),
                  code: codeController.text.trim(),
                  unit: unitController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0.0,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateEngineering(String id, EngineeringItem engineering) async {
    setState(() => _isLoading = true);
    try {
      final result = await controller.updateEngineering(id, engineering);
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Engineering updated successfully!');
        await _loadEngineering();
      } else {
        _showError(result['message'] ?? 'Failed to update engineering');
      }
    } catch (e) {
      _showError('Failed to update engineering: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteEngineering(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this engineering item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        final result = await controller.deleteEngineering(id);
        if (result['success'] == true) {
          _showSuccess(result['message'] ?? 'Engineering deleted successfully!');
          await _loadEngineering();
        } else {
          _showError(result['message'] ?? 'Failed to delete engineering');
        }
      } catch (e) {
        _showError('Failed to delete engineering: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _savePackages() async {
    setState(() => _isLoading = true);
    try {
      List<PackageItem> newPackages = [];
      for (var row in packageControllers) {
        if (row[0].text.trim().isNotEmpty) {
          newPackages.add(PackageItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }

      if (newPackages.isEmpty) {
        _showError('Please add at least one new package');
        setState(() => _isLoading = false);
        return;
      }

      final result = await controller.addPackages(newPackages);
      
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Packages saved successfully!');
        
        for (var row in packageControllers) {
          for (var ctrl in row) {
            ctrl.clear();
          }
        }
        
        await _loadPackages();
      } else {
        _showError(result['message'] ?? 'Failed to save packages');
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
      List<ServiceItem> newServices = [];
      for (var row in servicesControllers) {
        if (row[0].text.trim().isNotEmpty) {
          newServices.add(ServiceItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }

      if (newServices.isEmpty) {
        _showError('Please add at least one new service');
        setState(() => _isLoading = false);
        return;
      }

      final result = await controller.addServices(newServices);
      
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Services saved successfully!');
        
        for (var row in servicesControllers) {
          for (var ctrl in row) {
            ctrl.clear();
          }
        }
        
        await _loadServices();
      } else {
        _showError(result['message'] ?? 'Failed to save services');
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
      List<EngineeringItem> newEngineering = [];
      for (var row in engineeringControllers) {
        if (row[0].text.trim().isNotEmpty) {
          newEngineering.add(EngineeringItem(
            name: row[0].text.trim(),
            code: row[1].text.trim(),
            unit: row[2].text.trim(),
            price: double.tryParse(row[3].text) ?? 0.0,
          ));
        }
      }

      if (newEngineering.isEmpty) {
        _showError('Please add at least one new engineering item');
        setState(() => _isLoading = false);
        return;
      }

      final result = await controller.addEngineering(newEngineering);
      
      if (result['success'] == true) {
        _showSuccess(result['message'] ?? 'Engineering items saved successfully!');
        
        for (var row in engineeringControllers) {
          for (var ctrl in row) {
            ctrl.clear();
          }
        }
        
        await _loadEngineering();
      } else {
        _showError(result['message'] ?? 'Failed to save engineering');
      }
    } catch (e) {
      _showError('Failed to save engineering: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSuccess(String message) {
    _showAlert(message, const Color(0xff10B981));
  }

  void _showError(String message) {
    _showAlert(message, const Color(0xffEF4444));
  }

  void _showAlert(String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  backgroundColor == const Color(0xff10B981)
                      ? Icons.check_circle
                      : Icons.error,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  @override
  void dispose() {
    _packageScrollController.dispose();
    _servicesScrollController.dispose();
    _engineeringScrollController.dispose();
    
    for (var table in [packageControllers, servicesControllers, engineeringControllers]) {
      for (var row in table) {
        for (var ctrl in row) {
          ctrl.dispose();
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
                      // Always use horizontal scroll for smaller screens
                      if (constraints.maxWidth < 1400) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1400, // Minimum width for all three tables
                            child: Row(
                              children: _buildTableSections(constraints),
                            ),
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
        existingData: existingPackages,
        controllers: packageControllers,
        icon: Icons.inventory,
        gradient: AppTheme.primaryGradient,
        constraints: constraints,
        onSave: _savePackages,
        onUpdate: (item, index) => _showUpdatePackageDialog(item as PackageItem, index),
        onDelete: _deletePackage,
        scrollController: _packageScrollController,
      ),
      const SizedBox(width: 12),
      _tableSection(
        title: 'Services',
        existingData: existingServices,
        controllers: servicesControllers,
        icon: Icons.miscellaneous_services,
        gradient: AppTheme.secondaryGradient,
        constraints: constraints,
        onSave: _saveServices,
        onUpdate: (item, index) => _showUpdateServiceDialog(item as ServiceItem, index),
        onDelete: _deleteService,
        scrollController: _servicesScrollController,
      ),
      const SizedBox(width: 12),
      _tableSection(
        title: 'Engineering',
        existingData: existingEngineering,
        controllers: engineeringControllers,
        icon: Icons.engineering,
        gradient: AppTheme.accentGradient,
        constraints: constraints,
        onSave: _saveEngineering,
        onUpdate: (item, index) => _showUpdateEngineeringDialog(item as EngineeringItem, index),
        onDelete: _deleteEngineering,
        scrollController: _engineeringScrollController,
      ),
    ];
  }

  Widget _tableSection({
    required String title,
    required List<dynamic> existingData,
    required List<List<TextEditingController>> controllers,
    required IconData icon,
    required Gradient gradient,
    required BoxConstraints constraints,
    required VoidCallback onSave,
    required Function(dynamic, int) onUpdate,
    required Function(String) onDelete,
    required ScrollController scrollController,
  }) {
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
            _tableHeader(),
            Container(height: 1, color: Colors.grey.shade300),
            Expanded(
              child: _tableRows(
                existingData,
                controllers,
                onUpdate,
                onDelete,
                scrollController,
              ),
            ),
            _tableSaveButton(onSave, title),
          ],
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

  Widget _tableHeader() {
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
          _HeaderCell(width: 40, text: '#', icon: Icons.numbers),
          Expanded(flex: 3, child: _HeaderCell(text: 'Name', icon: Icons.text_fields)),
          Expanded(flex: 2, child: _HeaderCell(text: 'Code', icon: Icons.code)),
          Expanded(flex: 1, child: _HeaderCell(text: 'Unit', icon: Icons.linear_scale)),
          Expanded(flex: 2, child: _HeaderCell(text: 'Price (\$)', icon: Icons.attach_money)),
          _HeaderCell(width: 100, text: 'Actions', icon: Icons.settings),
        ],
      ),
    );
  }

  Widget _tableRows(
    List<dynamic> existingData,
    List<List<TextEditingController>> controllers,
    Function(dynamic, int) onUpdate,
    Function(String) onDelete,
    ScrollController scrollController,
  ) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: existingData.length + controllers.length,
        itemBuilder: (_, index) {
          final isExisting = index < existingData.length;
          
          return Container(
            height: 32,
            decoration: BoxDecoration(
              color: isExisting
                  ? const Color(0xffF3F4F6)
                  : (index % 2 == 0 ? Colors.white : AppTheme.cardColor),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _numberCell(index + 1, 40, isExisting),
                Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                if (isExisting) ...[
                  Expanded(flex: 3, child: _lockedCell(existingData[index].name)),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 2, child: _lockedCell(existingData[index].code)),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 1, child: _lockedCell(existingData[index].unit)),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 2, child: _lockedCell(existingData[index].price.toString())),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  _actionButtons(existingData[index], index, onUpdate, onDelete),
                ] else ...[
                  Expanded(flex: 3, child: _editCell(controllers[index - existingData.length][0])),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 2, child: _editCell(controllers[index - existingData.length][1])),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 1, child: _editCell(controllers[index - existingData.length][2])),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  Expanded(flex: 2, child: _editCell(controllers[index - existingData.length][3])),
                  Container(width: 1, height: double.infinity, color: Colors.grey.shade300),
                  SizedBox(width: 100),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _numberCell(int number, double width, bool isLocked) {
    return SizedBox(
      width: width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLocked)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.lock,
                  size: 10,
                  color: Colors.grey,
                ),
              ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked
                    ? Colors.grey.withOpacity(0.3)
                    : AppTheme.secondaryColor.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lockedCell(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: TextStyle(
          fontSize: 11,
          color: AppTheme.textSecondary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _editCell(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 11, color: AppTheme.textPrimary),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _actionButtons(
    dynamic item,
    int index,
    Function(dynamic, int) onUpdate,
    Function(String) onDelete,
  ) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => onUpdate(item, index),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.edit,
                size: 14,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => onDelete(item.id!),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.delete,
                size: 14,
                color: AppTheme.errorColor,
              ),
            ),
          ),
        ],
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
  final int? flex;

  const _HeaderCell({
    this.width,
    required this.text,
    required this.icon,
    this.flex,
  });

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
          Flexible(
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