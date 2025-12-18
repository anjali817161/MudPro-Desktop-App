// ==================== CONTROLLER ====================
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  var activePrimaryTab = 0.obs;
  var activeSectionTab = 0.obs;
  var activeSecondaryTab = 1.obs; // Well tab selected by default
  var isLocked = true.obs;
  var reports = <String>[].obs;
  var selectedReport = 11.obs; // #12 selected
  var casings = <List<String>>[].obs;

  void toggleLock() => isLocked.toggle();

  @override
  void onInit() {
    generateDummyReports();
    generateDummyCasings();
    super.onInit();
  }

  

  void generateDummyReports() {
    reports.assignAll([
      "#1  7830.0 ft",
      "#2  7830.0 ft",
      "#3  7830.0 ft",
      "#4  7843.0 ft",
      "#5  7855.0 ft",
      "#6  7890.0 ft",
      "#7  7930.0 ft",
      "#8  8630.0 ft",
      "#9  9055.0 ft",
      "#10  9055.0 ft",
      "#11  9055.0 ft",
      "#12  7830.0 ft",
    ]);
  }

  void generateDummyCasings() {
    casings.assignAll([
      ['9 5/8" Casing', "9.625", "47.000", "8.681", "0.0", "7830.0", "7830.0"],
      ['Liner', "7.000", "26.000", "6.276", "7590.0", "9053.0", "1463.0"],
    ]);
  }

  void addCasing(String description) {
    if (description.isNotEmpty) {
      casings.add([description, "", "", "", "", "", ""]);
    }
  }


   var selectedNodeId = ''.obs;

  /// Tree data (date → reports)
  final reportsTree = <ReportDate>[
    ReportDate(
      date: '11/26/2025',
      items: [
        '11 7830 ft 23:30',
      ],
    ),
    ReportDate(
      date: '11/27/2025',
      items: [
        '1 7830 ft 23:30',
        '2 7830 ft 23:30',
      ],
    ),
    ReportDate(
      date: '11/28/2025',
      items: [
        '3 7830 ft 23:30',
      ],
    ),
  ].obs;

  void navigate(String id) {
    selectedNodeId.value = id;
    // 👉 yahin se API / report load karna
  }
}

class ReportDate {
  final String date;
  final List<String> items;
  bool expanded;

  ReportDate({
    required this.date,
    required this.items,
    this.expanded = true,
  });
}
