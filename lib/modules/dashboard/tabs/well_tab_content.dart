import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/tabular_database.dart';

class WellTabContent extends StatelessWidget {
  final c = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        if (width < 800) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    LeftPortion(),
                    const SizedBox(height: 12),
                    MiddlePortion(),
                    const SizedBox(height: 12),
                    RightPortion(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height - 120,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT PORTION - General section (reduced width)
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 280, maxWidth: 320),
                        child: LeftPortion(),
                      ),

                      const SizedBox(width: 12),
                      // MIDDLE PORTION - Expanded width
                      Expanded(
                        flex: 4,
                        child: MiddlePortion(),
                      ),
                      const SizedBox(width: 12),
                      // RIGHT PORTION - Reduced width
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 200, maxWidth: 280),
                        child: RightPortion(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

// ==================== LEFT PORTION ====================
class LeftPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralSection(),
      ],
    );
  }
}

// ==================== GENERAL SECTION ====================
class GeneralSection extends StatefulWidget {
  @override
  _GeneralSectionState createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  final c = Get.find<DashboardController>();
  
  // Static data for dropdowns
  final List<String> engineerOptions = [
    'Keyur Agarwal',
    'John Smith',
    'Jane Doe',
    'Robert Johnson',
    'Michael Brown'
  ];
  
  final List<String> engineer2Options = [
    'Chandra Shekhar',
    'Alex Turner',
    'Sarah Williams',
    'David Miller',
    'Emily Davis'
  ];
 
  final List<String> activityOptions = [
    'Rig-up/Service',
    'Drilling',
    'Circulating',
    'Tripping',
    'Survey',
    'Logging',
    'Run Casing',
    'Testing',
    'Coring/Reaming',
    'Cementing'
  ];
  
  final List<String> intervalOptions = [
    '22° Hole',
    '16° Hole',
    '12 1/4° Hole',
    '8 1/2° Hole',
    '6 1/8° Hole',
    "Completion"
  ];
  
  // Controllers for editable fields
  final Map<String, TextEditingController> fieldControllers = {
    'Report #': TextEditingController(text: '12'),
    'User Report #': TextEditingController(),
    'Bottom T.': TextEditingController(text: '180.0'),
    'MD': TextEditingController(text: '9575.0'),
    'TVD': TextEditingController(text: '7683.0'),
    'Inc': TextEditingController(text: '89.38'),
    'Azi': TextEditingController(text: '299.50'),
    'WOB': TextEditingController(),
    'Rot. Wt.': TextEditingController(),
    'S/O Wt.': TextEditingController(),
    'P/U Wt.': TextEditingController(),
    'RPM': TextEditingController(),
    'ROP': TextEditingController(),
    'Off-bottom TQ': TextEditingController(),
    'On-bottom TQ': TextEditingController(),
    'Suction T.': TextEditingController(),
    'Additional Footage': TextEditingController(text: '0.0'),
    'NPT Time': TextEditingController(),
    'NPT Cost': TextEditingController(),
    'Depth Drilled': TextEditingController(text: '0.0'),
    'Operator Rep.': TextEditingController(text: 'Wang'),
    'Contractor Rep.': TextEditingController(text: 'Jerry'),
    'FIT': TextEditingController(text: 'Completion'),
    'Formation': TextEditingController(text: 'MaG'),
  };

  // Dropdown values
  String selectedDate = 'Tuesday, December 30, 2025';
  String selectedTime = '23:30';
  String selectedEngineer = 'Keyur Agarwal';
  String selectedEngineer2 = 'Chandra Shekhar';
  String selectedActivity = 'Cementing';
  String selectedInterval = 'Completion';

  @override
  void initState() {
    super.initState();
    // Initialize dropdown values in controllers
    fieldControllers['Engineer'] = TextEditingController(text: selectedEngineer);
    fieldControllers['Engineer 2'] = TextEditingController(text: selectedEngineer2);
    fieldControllers['Activity'] = TextEditingController(text: selectedActivity);
    fieldControllers['Interval'] = TextEditingController(text: selectedInterval);
    fieldControllers['Date'] = TextEditingController(text: selectedDate);
    fieldControllers['Time'] = TextEditingController(text: selectedTime);
  }

  @override
  void dispose() {
    fieldControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "General Information",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Table with 3 columns: Label, Value, Unit
          Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                },
                children: [
                  _buildTextFieldRow("Report #", "Report #", ""),
                  _buildTextFieldRow("User Report #", "User Report #", ""),
                  _buildDateRow("Date"),
                  _buildTimeRow("Time"),
                  _buildDropdownRow("Engineer", selectedEngineer, engineerOptions, (value) {
                    setState(() => selectedEngineer = value!);
                  }),
                  _buildDropdownRow("Engineer 2", selectedEngineer2, engineer2Options, (value) {
                    setState(() => selectedEngineer2 = value!);
                  }),
                  _buildTextFieldRow("Operator Rep.", "Operator Rep.", ""),
                  _buildTextFieldRow("Contractor Rep.", "Contractor Rep.", ""),
                  _buildDropdownRow("Activity", selectedActivity, activityOptions, (value) {
                    setState(() => selectedActivity = value!);
                  }),
                  _buildTextFieldRow("MD", "MD", "ft"),
                  _buildTextFieldRow("TVD", "TVD", "ft"),
                  _buildTextFieldRow("Inc", "Inc", "°"),
                  _buildTextFieldRow("Azi", "Azi", "°"),
                  _buildTextFieldRow("WOB", "WOB", "lbf"),
                  _buildTextFieldRow("Rot. Wt.", "Rot. Wt.", "lbf"),
                  _buildTextFieldRow("S/O Wt.", "S/O Wt.", "lbf"),
                  _buildTextFieldRow("P/U Wt.", "P/U Wt.", "lbf"),
                  _buildTextFieldRow("RPM", "RPM", "rpm"),
                  _buildTextFieldRow("ROP", "ROP", "ft/hr"),
                  _buildTextFieldRow("Off-bottom TQ", "Off-bottom TQ", "ft-lb"),
                  _buildTextFieldRow("On-bottom TQ", "On-bottom TQ", "ft-lb"),
                  _buildTextFieldRow("Suction T.", "Suction T.", "°F"),
                  _buildTextFieldRow("Bottom T.", "Bottom T.", "°F"),
                  _buildDropdownRow("Interval", selectedInterval, intervalOptions, (value) {
                    setState(() => selectedInterval = value!);
                  }),
                  _buildTextFieldRow("FIT", "FIT", "ppg"),
                  _buildTextFieldRow("Formation", "Formation", ""),
                  _buildTextFieldRow("Additional Footage", "Additional Footage", "ft"),
                  _buildTextFieldRow("NPT Time", "NPT Time", "hr"),
                  _buildTextFieldRow("NPT Cost", "NPT Cost", "\$"),
                  _buildTextFieldRow("Depth Drilled", "Depth Drilled", "ft"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTextFieldRow(String label, String fieldKey, String unit) {
    final controller = fieldControllers[fieldKey] ?? TextEditingController();

    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        // Label column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff2c3e50),
            ),
          ),
        ),
        // Value column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    controller.text.isNotEmpty ? controller.text : '-',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  child: TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 11, height: 1.2),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )),
        ),
        // Unit column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow _buildDateRow(String label) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        // Label column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff2c3e50),
            ),
          ),
        ),
        // Value column with date dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    selectedDate,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextButton(
                    onPressed: () => _showDatePicker(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              selectedDate,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                )),
        ),
        // Unit column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            "",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow _buildTimeRow(String label) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        // Label column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff2c3e50),
            ),
          ),
        ),
        // Value column with time dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    selectedTime,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTime,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, size: 16),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedTime = newValue;
                          });
                        }
                      },
                      items: [
                        '23:30',
                        '22:30',
                        '21:30',
                        '20:30',
                        '19:30',
                        '18:30',
                        '17:30',
                        '16:30'
                      ].map<DropdownMenuItem<String>>((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              time,
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )),
        ),
        // Unit column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            "",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow _buildDropdownRow(String label, String value, List<String> options,
      ValueChanged<String?> onChanged, {String unit = ""}) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        // Label column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff2c3e50),
            ),
          ),
        ),
        // Value column with dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, size: 16),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                      onChanged: onChanged,
                      items: options.map<DropdownMenuItem<String>>((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              option,
                              style: TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )),
        ),
        // Unit column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${_getDayOfWeek(picked.weekday)}, ${_getMonthName(picked.month)} ${picked.day}, ${picked.year}";
      });
    }
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }
}

// ==================== MIDDLE PORTION ====================
class MiddlePortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CasedHoleSection(),
        const SizedBox(height: 12),
        OpenHoleSection(),
        const SizedBox(height: 12),
        DrillStringSection(),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => TabularDatabaseView());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                backgroundColor: Color(0xff0d9488),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Tabular Database',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Calculate ID tapped');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                backgroundColor: Color(0xff0d9488),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Calculate ID',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== CASED HOLE SECTION ====================
class CasedHoleSection extends StatefulWidget {
  @override
  _CasedHoleSectionState createState() => _CasedHoleSectionState();
}

class _CasedHoleSectionState extends State<CasedHoleSection> {
  final c = Get.find<DashboardController>();

  // Casing types dropdown
  final List<String> casingTypes = [
    '30° CSG',
    '18 5/8° CSG',
    '13 3/8° CSG',
    '9 5/8° CSG',
    '7° LINER'
  ];
  String selectedCasingType = '30° CSG';

  final ScrollController scrollController = ScrollController();

  // Data for the table (12 rows total, some pre-filled)
  List<List<TextEditingController>> tableData = [
    [
      TextEditingController(text: '9 5/8" Casing'),
      TextEditingController(text: '9.625'),
      TextEditingController(text: '47.000'),
      TextEditingController(text: '8.681'),
      TextEditingController(text: '0.0'),
      TextEditingController(text: '7830.0'),
      TextEditingController(text: '7830.0'),
    ],
    [
      TextEditingController(text: 'Liner'),
      TextEditingController(text: '7.000'),
      TextEditingController(text: '26.000'),
      TextEditingController(text: '6.276'),
      TextEditingController(text: '7590.0'),
      TextEditingController(text: '9053.0'),
      TextEditingController(text: '1463.0'),
    ],
    // Empty rows with controllers for editability
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
  ];

  void _addCasing() {
    setState(() {
      tableData.add([
        TextEditingController(text: selectedCasingType),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }

  void _removeCasing(int index) {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var row in tableData) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Cased Hole",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 140,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCasingType,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, size: 16, color: Colors.white),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                          dropdownColor: Color(0xff0d9488),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedCasingType = newValue;
                              });
                            }
                          },
                          items: casingTypes.map<DropdownMenuItem<String>>((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  type,
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: _addCasing,
                      icon: Icon(Icons.add, color: Colors.white, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.all(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Table with scrollable content
          Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),  // No.
                        1: FixedColumnWidth(120), // Description
                        2: FixedColumnWidth(70),  // OD (in)
                        3: FixedColumnWidth(80),  // Wt. (lb/ft)
                        4: FixedColumnWidth(70),  // ID (in)
                        5: FixedColumnWidth(80),  // Top (ft)
                        6: FixedColumnWidth(80),  // Shoe (ft)
                        7: FixedColumnWidth(80),  // Len. (ft)
                      },
                      children: [
                        // Header row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xfff0f9ff),
                          ),
                          children: [
                            _buildTableHeaderCell("No.", TextAlign.center),
                            _buildTableHeaderCell("Description", TextAlign.left),
                            _buildTableHeaderCell("OD\n(in)", TextAlign.center),
                            _buildTableHeaderCell("Wt.\n(lb/ft)", TextAlign.center),
                            _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                            _buildTableHeaderCell("Top\n(ft)", TextAlign.center),
                            _buildTableHeaderCell("Shoe\n(ft)", TextAlign.center),
                            _buildTableHeaderCell("Len.\n(ft)", TextAlign.center),
                          ],
                        ),

                        // Data rows
                        ...tableData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final rowControllers = entry.value;
                          return _buildCasingDataRow(index, rowControllers);
                        }).toList(),

                        // Add empty rows to make total 12 rows
                        ...List.generate(max(0, 12 - tableData.length), (index) {
                          return _buildEmptyCasingRow(tableData.length + index);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildCasingDataRow(int rowIndex, List<TextEditingController> controllers) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        // No.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Description
        _buildEditableCell(controllers[0], TextAlign.left),
        // OD (in)
        _buildEditableCell(controllers[1], TextAlign.center),
        // Wt. (lb/ft)
        _buildEditableCell(controllers[2], TextAlign.center),
        // ID (in)
        _buildEditableCell(controllers[3], TextAlign.center),
        // Top (ft)
        _buildEditableCell(controllers[4], TextAlign.center),
        // Shoe (ft)
        _buildEditableCell(controllers[5], TextAlign.center),
        // Len. (ft)
        _buildEditableCell(controllers[6], TextAlign.center),
      ],
    );
  }

  TableRow _buildEmptyCasingRow(int rowIndex) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
      ],
    );
  }

  Widget _buildEditableCell(TextEditingController controller, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                controller.text.isNotEmpty ? controller.text : '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
                textAlign: align,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: align,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }
}

// ==================== OPEN HOLE SECTION ====================
class OpenHoleSection extends StatefulWidget {
  @override
  _OpenHoleSectionState createState() => _OpenHoleSectionState();
}

class _OpenHoleSectionState extends State<OpenHoleSection> {
  final c = Get.find<DashboardController>();

  // Scroll controller for the table
  final ScrollController scrollController = ScrollController();

  // Data for the table (10 rows total, some pre-filled)
  List<List<TextEditingController>> tableData = [
    [
      TextEditingController(text: '8.5" Hole'),
      TextEditingController(text: '8.500'),
      TextEditingController(text: '9055.0'),
      TextEditingController(),
    ],
    // Empty rows with controllers for editability
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
    [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()],
  ];

  bool cementPlug = false;
  final TextEditingController cementPlugVolController = TextEditingController();
  final TextEditingController plugTopController = TextEditingController();

  void _addRow() {
    setState(() {
      tableData.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }

  void _removeRow(int index) {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var row in tableData) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.explore, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Open Hole",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Container(
            constraints: BoxConstraints(maxHeight: 250),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),  // No.
                        1: FixedColumnWidth(140), // Description
                        2: FixedColumnWidth(80),  // ID (in)
                        3: FixedColumnWidth(100), // MD (ft)
                        4: FixedColumnWidth(100), // Washout (%)
                      },
                      children: [
                        // Header row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xfff0f9ff),
                          ),
                          children: [
                            _buildTableHeaderCell("No.", TextAlign.center),
                            _buildTableHeaderCell("Description", TextAlign.left),
                            _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                            _buildTableHeaderCell("MD\n(ft)", TextAlign.center),
                            _buildTableHeaderCell("Washout\n(%)", TextAlign.center),
                          ],
                        ),

                        // Data rows
                        ...tableData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final rowControllers = entry.value;
                          return _buildOpenHoleRow(index, rowControllers);
                        }).toList(),

                        // Add empty rows
                        ...List.generate(10 - tableData.length, (index) {
                          return _buildEmptyOpenHoleRow(tableData.length + index);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Cement Plug Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Obx(() => Checkbox(
                        value: cementPlug,
                        onChanged: c.isLocked.value ? null : (value) {
                          setState(() {
                            cementPlug = value ?? false;
                          });
                        },
                        visualDensity: VisualDensity.compact,
                      )),
                      Text(
                        "Cement Plug Vol.",
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(minWidth: 50),
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Obx(() => c.isLocked.value
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: Text(
                                    cementPlugVolController.text.isNotEmpty ? cementPlugVolController.text : '-',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                )
                              : TextField(
                                  controller: cementPlugVolController,
                                  style: TextStyle(fontSize: 11),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    border: InputBorder.none,
                                  ),
                                )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "Plug Top",
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(minWidth: 50),
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Obx(() => c.isLocked.value
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: Text(
                                    plugTopController.text.isNotEmpty ? plugTopController.text : '-',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                )
                              : TextField(
                                  controller: plugTopController,
                                  style: TextStyle(fontSize: 11),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    border: InputBorder.none,
                                  ),
                                )),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: c.isLocked.value ? null : () {
                          // Adjust length functionality
                        },
                        icon: Icon(Icons.tune, size: 20, color: Color(0xff0d9488)),
                        tooltip: 'Adjust Length',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildOpenHoleRow(int rowIndex, List<TextEditingController> controllers) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        // No.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Description
        _buildEditableCell(controllers[0], TextAlign.left),
        // ID (in)
        _buildEditableCell(controllers[1], TextAlign.center),
        // MD (ft)
        _buildEditableCell(controllers[2], TextAlign.center),
        // Washout (%)
        _buildEditableCell(controllers[3], TextAlign.center),
      ],
    );
  }

  TableRow _buildEmptyOpenHoleRow(int rowIndex) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
      ],
    );
  }

  Widget _buildEditableCell(TextEditingController controller, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                controller.text.isNotEmpty ? controller.text : '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
                textAlign: align,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: align,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }
}

// ==================== DRILL STRING SECTION ====================
class DrillStringSection extends StatefulWidget {
  @override
  _DrillStringSectionState createState() => _DrillStringSectionState();
}

class _DrillStringSectionState extends State<DrillStringSection> {
  final c = Get.find<DashboardController>();

  // Data for the table
  List<List<TextEditingController>> tableData = [
    [
      TextEditingController(text: 'DP'),
      TextEditingController(text: '5.000'),
      TextEditingController(),
      TextEditingController(text: '4.276'),
      TextEditingController(),
      TextEditingController(text: '7430.4'),
    ],
    [
      TextEditingController(text: 'X-OVER'),
      TextEditingController(text: '6.500'),
      TextEditingController(),
      TextEditingController(text: '2.630'),
      TextEditingController(),
      TextEditingController(text: '2.3'),
    ],
    [
      TextEditingController(text: 'DP'),
      TextEditingController(text: '4.000'),
      TextEditingController(),
      TextEditingController(text: '3.340'),
      TextEditingController(),
      TextEditingController(text: '851.5'),
    ],
    [
      TextEditingController(text: 'HWDP'),
      TextEditingController(text: '4.000'),
      TextEditingController(),
      TextEditingController(text: '2.438'),
      TextEditingController(),
      TextEditingController(text: '92.3'),
    ],
    [
      TextEditingController(text: 'JAR'),
      TextEditingController(text: '4.750'),
      TextEditingController(),
      TextEditingController(text: '2.250'),
      TextEditingController(),
      TextEditingController(text: '19.8'),
    ],
    [
      TextEditingController(text: 'HWDP'),
      TextEditingController(text: '4.000'),
      TextEditingController(),
      TextEditingController(text: '2.438'),
      TextEditingController(),
      TextEditingController(text: '551.7'),
    ],
    [
      TextEditingController(text: 'DC'),
      TextEditingController(text: '4.750'),
      TextEditingController(),
      TextEditingController(text: '3.340'),
      TextEditingController(),
      TextEditingController(text: '31.1'),
    ],
    [
      TextEditingController(text: 'BIT SUB'),
      TextEditingController(text: '4.750'),
      TextEditingController(),
      TextEditingController(text: '2.000'),
      TextEditingController(),
      TextEditingController(text: '3.0'),
    ],
  ];

  final TextEditingController totalLengthController = TextEditingController(text: '8982.0');
  final ScrollController scrollController = ScrollController();

  void _addRow() {
    setState(() {
      tableData.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }

  void _removeRow(int index) {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Drill String",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Container(
            constraints: BoxConstraints(maxHeight: 250),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(40),  // No.
                        1: FixedColumnWidth(140), // Description
                        2: FixedColumnWidth(80),  // OD (in)
                        3: FixedColumnWidth(100), // Wt. (lb/ft)
                        4: FixedColumnWidth(80),  // ID (in)
                        5: FixedColumnWidth(80),  // Grade
                        6: FixedColumnWidth(100), // Len. (ft)
                        7: FixedColumnWidth(40),  // Empty
                      },
                      children: [
                        // Header row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xfff0f9ff),
                          ),
                          children: [
                            _buildTableHeaderCell("No.", TextAlign.center),
                            _buildTableHeaderCell("Description", TextAlign.left),
                            _buildTableHeaderCell("OD\n(in)", TextAlign.center),
                            _buildTableHeaderCell("Wt.\n(lb/ft)", TextAlign.center),
                            _buildTableHeaderCell("ID\n(in)", TextAlign.center),
                            _buildTableHeaderCell("Grade", TextAlign.center),
                            _buildTableHeaderCell("Len.\n(ft)", TextAlign.center),
                            _buildTableHeaderCell("", TextAlign.center),
                          ],
                        ),

                        // Data rows
                        ...tableData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final rowControllers = entry.value;
                          return _buildDrillStringRow(index, rowControllers);
                        }).toList(),

                        // Add empty rows
                        ...List.generate(10 - tableData.length, (index) {
                          return _buildEmptyDrillStringRow(tableData.length + index);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Footer with editable total length
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xfff0f9ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Total String Length < Well Depth",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff0d9488),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Total Length (ft): ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0d9488),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Obx(() => c.isLocked.value
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Text(
                                totalLengthController.text,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff0d9488),
                                ),
                              ),
                            )
                          : TextField(
                              controller: totalLengthController,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff0d9488),
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                border: InputBorder.none,
                              ),
                            )),
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

  Widget _buildTableHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildDrillStringRow(int rowIndex, List<TextEditingController> controllers) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        // No.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Description
        _buildEditableCell(controllers[0], TextAlign.left),
        // OD (in)
        _buildEditableCell(controllers[1], TextAlign.center),
        // Wt. (lb/ft)
        _buildEditableCell(controllers[2], TextAlign.center),
        // ID (in)
        _buildEditableCell(controllers[3], TextAlign.center),
        // Grade
        _buildEditableCell(controllers[4], TextAlign.center),
        // Len. (ft)
        _buildEditableCell(controllers[5], TextAlign.center),
        // Empty
        _buildEmptyCell(),
      ],
    );
  }

  TableRow _buildEmptyDrillStringRow(int rowIndex) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
        _buildEmptyCell(),
      ],
    );
  }

  Widget _buildEditableCell(TextEditingController controller, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                controller.text.isNotEmpty ? controller.text : '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
                textAlign: align,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: align,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }
}

// ==================== RIGHT PORTION ====================
class RightPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BitSection(),
        const SizedBox(height: 12),
        NozzleSection(),
        const SizedBox(height: 12),
        TimeDistributionSection(),
      ],
    );
  }
}

// ==================== BIT SECTION ====================
class BitSection extends StatefulWidget {
  @override
  _BitSectionState createState() => _BitSectionState();
}

class _BitSectionState extends State<BitSection> {
  final c = Get.find<DashboardController>();
  
  // Data for the table
  final Map<String, TextEditingController> bitControllers = {
    'Mft': TextEditingController(text: 'VAREL'),
    'Type': TextEditingController(text: 'MT-TCI'),
    'No. of Bits': TextEditingController(text: '1'),
    'Size': TextEditingController(text: '22.000'),
    'Depth-in': TextEditingController(text: '65.0'),
    'Depth': TextEditingController(text: '96.0'),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.diamond, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Bit Information",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Padding(
            padding: const EdgeInsets.all(12),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(1),
              },
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfff0f9ff),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: Text(
                        "Field",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0d9488),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0d9488),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: Text(
                        "",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0d9488),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // Data rows
                _buildBitTableRow("Mft", "Mft", ""),
                _buildBitTableRow("Type", "Type", ""),
                _buildBitTableRow("No. of Bits", "No. of Bits", ""),
                _buildBitTableRow("Size", "Size", "in"),
                _buildBitTableRow("Depth-in", "Depth-in", "ft"),
                _buildBitTableRow("Depth", "Depth", "ft"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildBitTableRow(String label, String fieldKey, String unit) {
    final controller = bitControllers[fieldKey] ?? TextEditingController();

    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        // Field column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff2c3e50),
            ),
          ),
        ),
        // Value column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    controller.text.isNotEmpty ? controller.text : '-',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  child: TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 11, height: 1.2),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )),
        ),
        // Unit column
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ==================== NOZZLE SECTION ====================
class NozzleSection extends StatefulWidget {
  @override
  _NozzleSectionState createState() => _NozzleSectionState();
}

class _NozzleSectionState extends State<NozzleSection> {
  final c = Get.find<DashboardController>();
  
  // Data for the table
  List<List<TextEditingController>> tableData = [
    [
      TextEditingController(text: '1'),
      TextEditingController(text: '14'),
    ],
    [
      TextEditingController(text: '2'),
      TextEditingController(),
    ],
    [
      TextEditingController(text: '3'),
      TextEditingController(),
    ],
  ];
  
  final TextEditingController tfaController = TextEditingController(text: '0.518');

  void _addRow() {
    setState(() {
      tableData.add([
        TextEditingController(text: '${tableData.length + 1}'),
        TextEditingController(),
      ]);
    });
  }

  void _removeRow(int index) {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeAt(index);
        // Update numbers
        for (int i = 0; i < tableData.length; i++) {
          tableData[i][0].text = '${i + 1}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Nozzle Information",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(40),  // No.
                  1: FixedColumnWidth(90),  // #
                  2: FixedColumnWidth(120),  // Size (1/32in)
                },
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xfff0f9ff),
                    ),
                    children: [
                      _buildNozzleHeaderCell("#", TextAlign.center),
                      _buildNozzleHeaderCell("No.", TextAlign.center),
                      _buildNozzleHeaderCell("Size\n(1/32in)", TextAlign.center),
                    ],
                  ),
                  
                  // Data rows
                  ...tableData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final rowControllers = entry.value;
                    return _buildNozzleTableRow(index, rowControllers);
                  }).toList(),
                ],
              ),
            ),
          ),

          // TFA Footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TFA (in²)",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0d9488),
                  ),
                ),
                Container(
                  width: 80,
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Obx(() => c.isLocked.value
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Text(
                            tfaController.text,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff0d9488),
                            ),
                          ),
                        )
                      : TextField(
                          controller: tfaController,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0d9488),
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            border: InputBorder.none,
                          ),
                        )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNozzleHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildNozzleTableRow(int rowIndex, List<TextEditingController> controllers) {
    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        // No.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            '${rowIndex + 1}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // #
        _buildEditableCell(controllers[0], TextAlign.center),
        // Size (1/32in)
        _buildEditableCell(controllers[1], TextAlign.center),
      ],
    );
  }

  Widget _buildEditableCell(TextEditingController controller, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(() => c.isLocked.value
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                controller.text.isNotEmpty ? controller.text : '-',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
                textAlign: align,
              ),
            )
          : Container(
              height: 28,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 11, height: 1.2),
                textAlign: align,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )),
    );
  }
}

// ==================== TIME DISTRIBUTION SECTION ====================
class TimeDistributionSection extends StatefulWidget {
  @override
  _TimeDistributionSectionState createState() => _TimeDistributionSectionState();
}

class _TimeDistributionSectionState extends State<TimeDistributionSection> {
  final c = Get.find<DashboardController>();

  // Activity options for dropdown
  final List<String> activityOptions = [
    'Rig-up/Service',
    'Drilling',
    'Circulating',
    'Tripping',
    'Survey',
    'Logging',
    'Run Casing',
    'Testing',
    'Coring/Reaming',
    'Cementing'
  ];

  final ScrollController scrollController = ScrollController();

  // Data for the table
  List<List<dynamic>> tableData = [
    ['1', 'Rig-up/Service', '2.00'],
    ['2', 'Drilling', '2.30'],
    ['3', 'Circulating', '3.00'],
    ['4', 'Tripping', '2.00'],
    ['5', 'Survey', '1.30'],
    ['6', 'Tripping', '4.00'],
    ['7', 'Drilling Cement', '6.40'],
  ];

  void _addRow() {
    setState(() {
      tableData.add([
        '${tableData.length + 1}',
        activityOptions[0],
        ''
      ]);
    });
  }

  void _removeRow(int index) {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeAt(index);
        // Update numbers
        for (int i = 0; i < tableData.length; i++) {
          tableData[i][0] = '${i + 1}';
        }
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff0d9488),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  "Time Distribution",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Table
          Container(
            constraints: BoxConstraints(maxHeight: 250),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(50),  // #
                        1: FixedColumnWidth(130), // Activity
                        2: FixedColumnWidth(80),  // Time (hr)
                      },
                      children: [
                        // Header row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xfff0f9ff),
                          ),
                          children: [
                            _buildTimeHeaderCell("#", TextAlign.center),
                            _buildTimeHeaderCell("Activity", TextAlign.left),
                            _buildTimeHeaderCell("Time\n(hr)", TextAlign.center),
                          ],
                        ),

                        // Data rows
                        ...tableData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final rowData = entry.value;
                          return _buildTimeDistributionRow(index, rowData);
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeHeaderCell(String text, TextAlign align) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xff0d9488),
        ),
        textAlign: align,
      ),
    );
  }

  TableRow _buildTimeDistributionRow(int rowIndex, List<dynamic> rowData) {
    final TextEditingController timeController = TextEditingController(text: rowData[2]);

    return TableRow(
      decoration: BoxDecoration(
        color: rowIndex % 2 == 0 ? Colors.white : Colors.grey.shade50,
      ),
      children: [
        // #
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            rowData[0],
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Activity with dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    rowData[1],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: rowData[1],
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, size: 16),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            tableData[rowIndex][1] = newValue;
                          });
                        }
                      },
                      items: activityOptions.map<DropdownMenuItem<String>>((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              option,
                              style: TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )),
        ),
        // Time (hr)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => c.isLocked.value
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    timeController.text.isNotEmpty ? timeController.text : '-',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  height: 28,
                  child: TextField(
                    controller: timeController,
                    style: TextStyle(fontSize: 11, height: 1.2),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      tableData[rowIndex][2] = value;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )),
        ),
      ],
    );
  }
}