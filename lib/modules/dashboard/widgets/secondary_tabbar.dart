import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../controller/dashboard_controller.dart';

class SecondaryTabBar extends StatelessWidget {
  SecondaryTabBar({super.key});

  final controller = Get.find<DashboardController>();

  final List<Map<String, dynamic>> tabs = [
    {"name": "New Report", "icon": Icons.add_circle_outline},
    {"name": "Open Folder", "icon": Icons.folder_open},
    {"name": "Save", "icon": Icons.save},
    {"name": "Save as", "icon": Icons.save_as},
    {"name": "Carry-over pad", "icon": Icons.copy_all},
    {"name": "New Report", "icon": Icons.insert_drive_file},
    {"name": "Carry-over", "icon": Icons.forward},
    {"name": "Lock", "icon": Icons.lock},
    {"name": "Calculate", "icon": Icons.calculate},
    {"name": "Options", "icon": Icons.settings},
    {"name": "Mud company setup", "icon": Icons.business},
    {"name": "Upload", "icon": Icons.upload},
    {"name": "Batch Upload", "icon": Icons.cloud_upload},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: const Color(0xffE8E8E8),
      child: Row(
        children: [
          // Left side - Tabs with icons
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    children: List.generate(tabs.length, (index) {
                      final isActive =
                          controller.activeSecondaryTab.value == index;

                      return GestureDetector(
                        onTap: () => _handleTabAction(context, index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: isActive
                                    ? const Color(0xff2196F3)
                                    : Colors.transparent,
                                width: 3,
                              ),
                              right: const BorderSide(color: Colors.black12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                tabs[index]["icon"],
                                size: 16,
                                color: isActive
                                    ? const Color(0xff2196F3)
                                    : Colors.black87,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                tabs[index]["name"],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: isActive
                                      ? Colors.black87
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )),
            ),
          ),

          // Right side - Info fields
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.black26, width: 2)),
            ),
            child: Row(
              children: [
                _buildInfoField("Well", "UG-0293 ST"),
                const SizedBox(width: 12),
                _buildInfoField("Date", "12/27/2025"),
                const SizedBox(width: 12),
                _buildInfoField("Report #", "12"),
                const SizedBox(width: 12),
                _buildInfoField("MD (ft)", "9055.0"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xffFFFDE7),
                border: Border.all(color: Colors.black38, width: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                controller.isLocked.value ? value : value,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ],
    );
  }

  void _handleTabAction(BuildContext context, int index) async {
    controller.activeSecondaryTab.value = index;

    switch (index) {
      case 0: // New Report
        _createNewReport(context);
        break;
      case 1: // Open Folder
        await _openFolder(context);
        break;
      case 2: // Save
        await _saveReport(context, false);
        break;
      case 3: // Save as
        await _saveReport(context, true);
        break;
      case 4: // Carry-over pad
        _carryOverPad(context);
        break;
      case 5: // New Report (duplicate)
        _createNewReport(context);
        break;
      case 6: // Carry-over
        _carryOver(context);
        break;
      case 7: // Lock
        _toggleLock(context);
        break;
      case 8: // Calculate
        _performCalculations(context);
        break;
      case 9: // Options
        _showOptions(context);
        break;
      case 10: // Mud company setup
        _showMudCompanySetup(context);
        break;
      case 11: // Upload
        await _uploadFile(context);
        break;
      case 12: // Batch Upload
        await _batchUpload(context);
        break;
    }
  }

  // ==================== DESKTOP ALERT ====================
  void _showDesktopAlert(BuildContext context, String message, {bool isSuccess = true}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60,
        right: 20,
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isSuccess ? const Color(0xff4CAF50) : const Color(0xffF44336),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? const Color(0xff4CAF50) : const Color(0xffF44336),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  // ==================== NEW REPORT ====================
  void _createNewReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.add_circle_outline, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Create New Report", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Well Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "Report Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              controller.generateDummyReports();
              Navigator.pop(context);
              _showDesktopAlert(context, "New report created successfully");
            },
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
        ],
      ),
    );
  }

  // ==================== OPEN FOLDER ====================
  Future<void> _openFolder(BuildContext context) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final directory = Directory(selectedDirectory);
        final files = directory.listSync();
        
        _showFilesDialog(context, files, selectedDirectory);
      }
    } catch (e) {
      _showDesktopAlert(context, "Failed to open folder", isSuccess: false);
    }
  }

  void _showFilesDialog(BuildContext context, List<FileSystemEntity> files, String path) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Files in Folder", style: TextStyle(fontSize: 16)),
        content: SizedBox(
          width: 500,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    const Icon(Icons.folder, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        path,
                        style: const TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    final isDirectory = file is Directory;
                    final name = file.path.split(Platform.pathSeparator).last;

                    return ListTile(
                      leading: Icon(
                        isDirectory ? Icons.folder : Icons.insert_drive_file,
                        color: isDirectory ? Colors.amber : Colors.blue,
                      ),
                      title: Text(name, style: const TextStyle(fontSize: 12)),
                      trailing: Text(
                        isDirectory ? "Folder" : "File",
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // ==================== SAVE REPORT ====================
  Future<void> _saveReport(BuildContext context, bool saveAs) async {
    try {
      String? filePath = await FilePicker.platform.saveFile(
        dialogTitle: saveAs ? 'Save Report As' : 'Save Report',
        fileName: 'mudpro_report_${DateTime.now().millisecondsSinceEpoch}.json',
        type: FileType.custom,
        allowedExtensions: ['json', 'txt', 'csv'],
      );

      if (filePath != null) {
        final reportData = {
          'well': 'UG-0293 ST',
          'date': '12/27/2025',
          'reportNumber': '12',
          'md': '9055.0',
          'reports': controller.reports.toList(),
          'timestamp': DateTime.now().toIso8601String(),
        };

        final file = File(filePath);
        await file.writeAsString(jsonEncode(reportData));

        _showDesktopAlert(context, "Report saved successfully");
      }
    } catch (e) {
      _showDesktopAlert(context, "Failed to save report", isSuccess: false);
    }
  }

  // ==================== CARRY-OVER PAD ====================
  void _carryOverPad(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.copy_all, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Carry-over Pad", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: const Text(
          "This will copy current pad data to a new report. Continue?",
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showDesktopAlert(context, "Pad data carried over successfully");
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  // ==================== CARRY-OVER ====================
  void _carryOver(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.forward, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Carry-over Report", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select fields to carry over to next report:",
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text("General Info", style: TextStyle(fontSize: 12)),
              value: true,
              onChanged: (val) {},
            ),
            CheckboxListTile(
              title: const Text("Well Data", style: TextStyle(fontSize: 12)),
              value: true,
              onChanged: (val) {},
            ),
            CheckboxListTile(
              title: const Text("Mud Properties", style: TextStyle(fontSize: 12)),
              value: false,
              onChanged: (val) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showDesktopAlert(context, "Data carried over to new report");
            },
            child: const Text("Carry Over"),
          ),
        ],
      ),
    );
  }

  // ==================== TOGGLE LOCK ====================
  void _toggleLock(BuildContext context) {
    controller.toggleLock();
    _showDesktopAlert(
      context,
      controller.isLocked.value
          ? "Report locked for editing"
          : "Report unlocked for editing",
    );
  }

  // ==================== CALCULATE ====================
  void _performCalculations(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.calculate, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Perform Calculations", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select calculations to perform:",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _calcOption("Calculate Well Volume"),
            _calcOption("Calculate String Length"),
            _calcOption("Calculate TFA"),
            _calcOption("Calculate Mud Weight"),
            _calcOption("Calculate Pressure"),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.blue.shade50,
              child: const Text(
                "Calculations will update all related fields automatically.",
                style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              
              // Show progress dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("Calculating..."),
                        ],
                      ),
                    ),
                  ),
                ),
              );

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                _showDesktopAlert(context, "All calculations completed successfully");
              });
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Calculate"),
          ),
        ],
      ),
    );
  }

  Widget _calcOption(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ==================== OPTIONS ====================
  void _showOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.settings, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Options", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text("Auto Save", style: TextStyle(fontSize: 12)),
                subtitle: const Text("Automatically save changes",
                    style: TextStyle(fontSize: 10)),
                value: true,
                onChanged: (val) {},
              ),
              SwitchListTile(
                title: const Text("Auto Calculate", style: TextStyle(fontSize: 12)),
                subtitle: const Text("Calculate on data change",
                    style: TextStyle(fontSize: 10)),
                value: false,
                onChanged: (val) {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.format_paint),
                title: const Text("Theme", style: TextStyle(fontSize: 12)),
                trailing: const Text("Light", style: TextStyle(fontSize: 11)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Units", style: TextStyle(fontSize: 12)),
                trailing: const Text("Imperial", style: TextStyle(fontSize: 11)),
                onTap: () {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showDesktopAlert(context, "Options saved successfully");
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ==================== MUD COMPANY SETUP ====================
  void _showMudCompanySetup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.business, color: Color(0xff2196F3)),
            SizedBox(width: 8),
            Text("Mud Company Setup", style: TextStyle(fontSize: 16)),
          ],
        ),
        content: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Company Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Contact Person",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showDesktopAlert(context, "Mud company setup saved");
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ==================== UPLOAD FILE ====================
  Future<void> _uploadFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'csv', 'txt', 'xlsx'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Uploading..."),
                  ],
                ),
              ),
            ),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);

        _showDesktopAlert(context, "File '${file.name}' uploaded successfully");
      }
    } catch (e) {
      _showDesktopAlert(context, "Failed to upload file", isSuccess: false);
    }
  }

  // ==================== BATCH UPLOAD ====================
  Future<void> _batchUpload(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['json', 'csv', 'txt', 'xlsx'],
      );

      if (result != null) {
        List<PlatformFile> files = result.files;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Batch Upload", style: TextStyle(fontSize: 16)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Uploading ${files.length} files...",
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),
                const LinearProgressIndicator(),
              ],
            ),
          ),
        );

        await Future.delayed(const Duration(seconds: 3));
        Navigator.pop(context);

        _showDesktopAlert(context, "${files.length} files uploaded successfully");
      }
    } catch (e) {
      _showDesktopAlert(context, "Failed to upload files", isSuccess: false);
    }
  }
}