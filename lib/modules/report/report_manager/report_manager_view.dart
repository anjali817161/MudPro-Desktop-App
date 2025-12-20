import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/report/controller/report_manager_controller.dart';

class ReportManagerPage extends StatefulWidget {
  const ReportManagerPage({super.key});

  @override
  State<ReportManagerPage> createState() => _ReportManagerPageState();
}

class _ReportManagerPageState extends State<ReportManagerPage> {
  final ReportManagerController rmC = Get.put(ReportManagerController());

  // ---------------- CURRENT WELL ----------------
  String selectedWell = 'UG-0293 ST';
  final wells = ['UG-0293 ST', 'UG-0451 ST', 'UG-0678 ST'];

  // ---------------- SEARCH CRITERIA ----------------
  final criteria = [
    'Date',
    'Report No.',
    'Depth (m)',
    'MW (ppg)',
    'Recommended Tour Treatment',
    'Remarks',
    'Recap Remarks',
    'Internal Notes',
  ];

  final Map<String, bool> checked = {};
  final Map<String, TextEditingController> minCtrl = {};
  final Map<String, TextEditingController> maxCtrl = {};

  // ---------------- RESULT TABLE ----------------
  int? selectedRowIndex;

  final List<Map<String, dynamic>> reports = [
    {
      'date': '11/26/2025',
      'report': 1,
      'md': 2386.59,
      'activity': 'Tripping',
      'interval': 'Suspension',
      'mud': 'Water-based',
      'mw': 8.40,
      'daily': 0.0,
      'cum': 0.0,
    },
    {
      'date': '11/27/2025',
      'report': 2,
      'md': 2386.59,
      'activity': 'Tripping',
      'interval': 'Suspension',
      'mud': 'Water-based',
      'mw': 8.40,
      'daily': 0.0,
      'cum': 0.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var c in criteria) {
      checked[c] = false;
      minCtrl[c] = TextEditingController();
      maxCtrl[c] = TextEditingController();
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade100,
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 10),

              Expanded(
                child: Row(
                  children: [
                    _buildSearchCriteria(),
                    const SizedBox(width: 10),
                    _buildResultTable(),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              _buildBottomButtons(),
            ],
          ),
        );
      },
    );
  }

  // ================= TOP =================
  Widget _buildTopBar() {
  return Row(
    children: [
      const Text(
        'Current Well',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      const SizedBox(width: 10),

      DropdownButton<String>(
        value: selectedWell,
        items: wells
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: rmC.isLocked.value
            ? null
            : (v) => setState(() => selectedWell = v!),
      ),

      const Spacer(),

      Obx(() => ElevatedButton.icon(
            onPressed: rmC.toggleLock,
            icon: Icon(
              rmC.isLocked.value ? Icons.lock : Icons.lock_open,
              size: 16,
            ),
            label: Text(
              rmC.isLocked.value ? 'Locked' : 'Unlocked',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: rmC.isLocked.value
                  ? Colors.grey.shade600
                  : Colors.green,
            ),
          )),
    ],
  );
}


  // ================= LEFT =================
  Widget _buildSearchCriteria() {
    return Container(
      width: 380,
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Search Criteria'),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(32),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                border: TableBorder.all(color: Colors.grey.shade300),
                children: [
                  _tableHeader(),
                  ...criteria.map(_criteriaRow),
                ],
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: _clearAll,
                child: const Text('Clear All'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _search,
                child: const Text('Search'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _tableHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xffE5E7EB)),
      children: [
        SizedBox(),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text('Variable',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text('Min',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text('Max',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  TableRow _criteriaRow(String name) {
    return TableRow(
      children: [
       Checkbox(
  value: checked[name],
  onChanged: rmC.isLocked.value
      ? null
      : (v) => setState(() => checked[name] = v!),
),

        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(name, style: const TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
  controller: minCtrl[name],
  enabled: !rmC.isLocked.value,
  decoration: const InputDecoration(isDense: true),
),

        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
  controller: maxCtrl[name],
  enabled: !rmC.isLocked.value,
  decoration: const InputDecoration(isDense: true),
),

        ),
      ],
    );
  }

  

  // ================= RIGHT =================
  Widget _buildResultTable() {
    return Expanded(
      child: Container(
        decoration: _box(),
        child: Column(
          children: [
            _sectionHeader('Result'),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 36,
                  dataRowHeight: 32,
                  columns: const [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Report No')),
                    DataColumn(label: Text('MD (m)')),
                    DataColumn(label: Text('Activity')),
                    DataColumn(label: Text('Interval')),
                    DataColumn(label: Text('Mud Type')),
                    DataColumn(label: Text('MW')),
                    DataColumn(label: Text('Daily Cost')),
                    DataColumn(label: Text('Cum Cost')),
                  ],
                  rows: List.generate(reports.length, (i) {
                    final r = reports[i];
                    return DataRow(
                      selected: selectedRowIndex == i,
                      onSelectChanged: (_) =>
                          setState(() => selectedRowIndex = i),
                      cells: [
                        DataCell(Text(r['date'].toString())),
                        DataCell(Text(r['report'].toString())),
                        DataCell(Text(r['md'].toString())),
                        DataCell(Text(r['activity'])),
                        DataCell(Text(r['interval'])),
                        DataCell(Text(r['mud'])),
                        DataCell(Text(r['mw'].toString())),
                        DataCell(Text(r['daily'].toString())),
                        DataCell(Text(r['cum'].toString())),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BOTTOM =================
  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: _deleteRow,
          child: const Text('Delete'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _selectRow,
          child: const Text('Select'),
        ),
      ],
    );
  }

  // ================= ACTIONS =================
  void _clearAll() {
    setState(() {
      for (var k in checked.keys) {
        checked[k] = false;
        minCtrl[k]!.clear();
        maxCtrl[k]!.clear();
      }
    });
  }

  void _search() {
    // 🔹 API filter logic later
    debugPrint('Search clicked');
  }

  void _deleteRow() {
    if (selectedRowIndex != null) {
      setState(() {
        reports.removeAt(selectedRowIndex!);
        selectedRowIndex = null;
      });
    }
  }

  void _selectRow() {
    if (selectedRowIndex != null) {
      debugPrint('Selected row: $selectedRowIndex');
    }
  }

  // ================= UTIL =================
  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      );

  Widget _sectionHeader(String title) {
    return Container(
      height: 36,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  
}
