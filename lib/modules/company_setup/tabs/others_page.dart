import 'package:flutter/material.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import 'package:mudpro_desktop_app/modules/company_setup/controller/others_controller.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/others_model.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({super.key});

  @override
  State<OthersPage> createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  // Dynamic row counts for each table
  int _activityRowCount = 1;
  int _additionRowCount = 1;
  int _lossRowCount = 1;
  int _waterRowCount = 1;
  int _oilRowCount = 1;
  int _syntheticRowCount = 1;

  // Controller instance
  late final OthersController _controller = OthersController();

  // State variables for loaded data
  List<ActivityItem> _loadedActivities = [];
  List<AdditionItem> _loadedAdditions = [];
  List<LossItem> _loadedLosses = [];
  List<WaterBasedItem> _loadedWaterBased = [];
  List<OilBasedItem> _loadedOilBased = [];
  List<SyntheticItem> _loadedSynthetic = [];

  // State variables for locked rows (indices of loaded data)
  Set<int> _lockedActivityRows = {};
  Set<int> _lockedAdditionRows = {};
  Set<int> _lockedLossRows = {};
  Set<int> _lockedWaterRows = {};
  Set<int> _lockedOilRows = {};
  Set<int> _lockedSyntheticRows = {};

  // Loading states
  bool _isLoading = true;
  String? _errorMessage;

  List<TextEditingController> _genSingleCol(int count) =>
      List.generate(count, (_) => TextEditingController());

  int _getRowCountForTable(String title) {
    switch (title) {
      case 'Addition':
        return _additionRowCount;
      case 'Loss':
        return _lossRowCount;
      case 'Water-based':
        return _waterRowCount;
      case 'Oil-based':
        return _oilRowCount;
      case 'Synthetic':
        return _syntheticRowCount;
      default:
        return 1;
    }
  }

  List<TextEditingController> _activityControllers = [];
  List<TextEditingController> _additionControllers = [];
  List<TextEditingController> _lossControllers = [];
  List<TextEditingController> _waterControllers = [];
  List<TextEditingController> _oilControllers = [];
  List<TextEditingController> _syntheticControllers = [];

  List<TextEditingController> get activity => _activityControllers;
  List<TextEditingController> get addition => _additionControllers;
  List<TextEditingController> get loss => _lossControllers;
  List<TextEditingController> get water => _waterControllers;
  List<TextEditingController> get oil => _oilControllers;
  List<TextEditingController> get synthetic => _syntheticControllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _fetchAllData();
  }

  void _initializeControllers() {
    _activityControllers = _genSingleCol(_activityRowCount);
    _additionControllers = _genSingleCol(_additionRowCount);
    _lossControllers = _genSingleCol(_lossRowCount);
    _waterControllers = _genSingleCol(_waterRowCount);
    _oilControllers = _genSingleCol(_oilRowCount);
    _syntheticControllers = _genSingleCol(_syntheticRowCount);

    // Add listeners for dynamic row addition
    _addListenersToControllers(_activityControllers, 'Activity');
    _addListenersToControllers(_additionControllers, 'Addition');
    _addListenersToControllers(_lossControllers, 'Loss');
    _addListenersToControllers(_waterControllers, 'Water-based');
    _addListenersToControllers(_oilControllers, 'Oil-based');
    _addListenersToControllers(_syntheticControllers, 'Synthetic');
  }

  void _addListenersToControllers(List<TextEditingController> controllers, String tableType) {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.trim().isNotEmpty && i == controllers.length - 1) {
          // Last row is filled, add a new row
          _addNewRow(tableType);
        }
      });
    }
  }

  void _addNewRow(String tableType) {
    setState(() {
      switch (tableType) {
        case 'Activity':
          _activityRowCount++;
          _activityControllers.add(TextEditingController());
          _activityControllers.last.addListener(() {
            if (_activityControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Activity');
            }
          });
          break;
        case 'Addition':
          _additionRowCount++;
          _additionControllers.add(TextEditingController());
          _additionControllers.last.addListener(() {
            if (_additionControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Addition');
            }
          });
          break;
        case 'Loss':
          _lossRowCount++;
          _lossControllers.add(TextEditingController());
          _lossControllers.last.addListener(() {
            if (_lossControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Loss');
            }
          });
          break;
        case 'Water-based':
          _waterRowCount++;
          _waterControllers.add(TextEditingController());
          _waterControllers.last.addListener(() {
            if (_waterControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Water-based');
            }
          });
          break;
        case 'Oil-based':
          _oilRowCount++;
          _oilControllers.add(TextEditingController());
          _oilControllers.last.addListener(() {
            if (_oilControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Oil-based');
            }
          });
          break;
        case 'Synthetic':
          _syntheticRowCount++;
          _syntheticControllers.add(TextEditingController());
          _syntheticControllers.last.addListener(() {
            if (_syntheticControllers.last.text.trim().isNotEmpty) {
              _addNewRow('Synthetic');
            }
          });
          break;
      }
    });
  }

  Future<void> _fetchAllData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Fetch data for all tables in parallel
      final results = await Future.wait([
        _controller.getActivities(),
        _controller.getAdditions(),
        _controller.getLosses(),
        _controller.getWaterBased(),
        _controller.getOilBased(),
        _controller.getSynthetic(),
      ]);

      setState(() {
        _loadedActivities = results[0] as List<ActivityItem>;
        _loadedAdditions = results[1] as List<AdditionItem>;
        _loadedLosses = results[2] as List<LossItem>;
        _loadedWaterBased = results[3] as List<WaterBasedItem>;
        _loadedOilBased = results[4] as List<OilBasedItem>;
        _loadedSynthetic = results[5] as List<SyntheticItem>;

        // Update row counts and controllers
        _activityRowCount = _loadedActivities.length + 1;
        _additionRowCount = _loadedAdditions.length + 1;
        _lossRowCount = _loadedLosses.length + 1;
        _waterRowCount = _loadedWaterBased.length + 1;
        _oilRowCount = _loadedOilBased.length + 1;
        _syntheticRowCount = _loadedSynthetic.length + 1;

        _initializeControllers();

        // Populate controllers with loaded data and lock rows
        for (int i = 0; i < _loadedActivities.length; i++) {
          _activityControllers[i].text = _loadedActivities[i].description;
          _lockedActivityRows.add(i);
        }
        for (int i = 0; i < _loadedAdditions.length; i++) {
          _additionControllers[i].text = _loadedAdditions[i].name;
          _lockedAdditionRows.add(i);
        }
        for (int i = 0; i < _loadedLosses.length; i++) {
          _lossControllers[i].text = _loadedLosses[i].name;
          _lockedLossRows.add(i);
        }
        for (int i = 0; i < _loadedWaterBased.length; i++) {
          _waterControllers[i].text = _loadedWaterBased[i].name;
          _lockedWaterRows.add(i);
        }
        for (int i = 0; i < _loadedOilBased.length; i++) {
          _oilControllers[i].text = _loadedOilBased[i].name;
          _lockedOilRows.add(i);
        }
        for (int i = 0; i < _loadedSynthetic.length; i++) {
          _syntheticControllers[i].text = _loadedSynthetic[i].name;
          _lockedSyntheticRows.add(i);
        }

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data: $e';
      });
    }
  }

  @override
  void dispose() {
    for (var controller in [...activity, ...addition, ...loss, ...water, ...oil, ...synthetic]) {
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth;
            
            if (availableWidth < 1000) {
              return _mobileLayout();
            } else if (availableWidth < 1400) {
              return _mediumLayout();
            } else {
              return _desktopLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _twoColTable(
                  title: 'Activity',
                  controllers: activity,
                  width: double.infinity,
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _singleColTable(title: 'Addition', controllers: addition),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Loss', controllers: loss),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Water-based', controllers: water),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Oil-based', controllers: oil),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Synthetic', controllers: synthetic),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _footerButtons(),
      ],
    );
  }

  Widget _mediumLayout() {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _twoColTable(
                title: 'Activity',
                controllers: activity,
                width: 250,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _singleColTable(title: 'Addition', controllers: addition),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Loss', controllers: loss),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Water-based', controllers: water),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Oil-based', controllers: oil),
                      const SizedBox(width: 12),
                      _singleColTable(title: 'Synthetic', controllers: synthetic),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _footerButtons(),
      ],
    );
  }

  Widget _desktopLayout() {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _twoColTable(
                title: 'Activity',
                controllers: activity,
                width: 300,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final totalTablesWidth = 5 * 210 + 4 * 12; // 5 tables * 210 width + 4 gaps * 12
                    if (constraints.maxWidth >= totalTablesWidth) {
                      // If there's enough space, show all tables without scrolling
                      return Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Flexible(
                                  child: _singleColTable(title: 'Addition', controllers: addition),
                                ),
                                const SizedBox(height: 12),
                                Flexible(
                                  child: _singleColTable(title: 'Loss', controllers: loss),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Flexible(
                                  child: _singleColTable(title: 'Water-based', controllers: water),
                                ),
                                const SizedBox(height: 12),
                                Flexible(
                                  child: _singleColTable(title: 'Oil-based', controllers: oil),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            flex: 1,
                            child: _singleColTable(title: 'Synthetic', controllers: synthetic),
                          ),
                        ],
                      );
                    } else {
                      // If not enough space, use horizontal scrolling
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _singleColTable(title: 'Addition', controllers: addition),
                            const SizedBox(width: 12),
                            _singleColTable(title: 'Loss', controllers: loss),
                            const SizedBox(width: 12),
                            _singleColTable(title: 'Water-based', controllers: water),
                            const SizedBox(width: 12),
                            _singleColTable(title: 'Oil-based', controllers: oil),
                            const SizedBox(width: 12),
                            _singleColTable(title: 'Synthetic', controllers: synthetic),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        _footerButtons(),
      ],
    );
  }

  // ======================================================
  // ACTIVITY TABLE (2 COLUMNS) - FIXED
  // ======================================================
  Widget _twoColTable({
    required String title,
    required List<TextEditingController> controllers,
    required double width,
  }) {
    final columnWidths = [50.0, width - 51]; // Account for 1px border
    return Container(
      width: width,
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
          _sectionHeader(title, Icons.list_alt, AppTheme.primaryGradient),
          _headerRow(['#', 'Description'], columnWidths),
          Expanded(child: _rows2Col(controllers, columnWidths[1])),
          _tableSaveButton(title),
        ],
      ),
    );
  }

  Widget _rows2Col(
      List<TextEditingController> controllers, double secondColWidth) {
    final scrollController = ScrollController();
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: _activityRowCount,
        itemBuilder: (_, row) {
          final isLocked = _lockedActivityRows.contains(row);
          return Container(
            height: 32,
            decoration: BoxDecoration(
              color: row % 2 == 0 ? Colors.white : AppTheme.cardColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  _numCell(row),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  _editCell(secondColWidth, controllers[row], isLocked: isLocked),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ======================================================
  // SINGLE COLUMN TABLES - FIXED
  // =====================================================
  Widget _singleColTable({
    required String title,
    required List<TextEditingController> controllers,
  }) {
    final gradients = [
      AppTheme.secondaryGradient,
      AppTheme.accentGradient,
      AppTheme.headerGradient,
      LinearGradient(
        colors: [Color(0xffFFB347), Color(0xffFFCC33)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xffDA70D6), Color(0xff9370DB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xff20B2AA), Color(0xff40E0D0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ];

    final icons = [
      Icons.add_circle,
      Icons.remove_circle,
      Icons.water_drop,
      Icons.local_gas_station,
      Icons.science,
    ];

    final iconIndex = ['Addition', 'Loss', 'Water-based', 'Oil-based', 'Synthetic']
        .indexOf(title);

    final columnWidths = [50.0, 159.0];
    final tableWidth = columnWidths[0] + columnWidths[1] + 1; // 50 + 159 + 1 border

    return Container(
      width: tableWidth,
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
          _sectionHeader(
            title,
            iconIndex >= 0 ? icons[iconIndex] : Icons.category,
            iconIndex >= 0 ? gradients[iconIndex] : AppTheme.primaryGradient,
          ),
          _headerRow(['#', title], columnWidths),
          Expanded(child: _rowsSingleCol(controllers, columnWidths[1], _getRowCountForTable(title), title)),
          _tableSaveButton(title),
        ],
      ),
    );
  }

  Widget _tableSaveButton(String tableTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ElevatedButton(
        onPressed: () => _saveTableData(tableTitle),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 1,
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _rowsSingleCol(List<TextEditingController> controllers, double secondColWidth, int rowCount, String tableTitle) {
    final scrollController = ScrollController();
    Set<int> lockedRows = _getLockedRowsForTable(tableTitle);

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: rowCount,
        itemBuilder: (_, row) {
          final isLocked = lockedRows.contains(row);
          return Container(
            height: 32,
            decoration: BoxDecoration(
              color: row % 2 == 0 ? Colors.white : AppTheme.cardColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  _numCell(row),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  _editCell(secondColWidth, controllers[row], isLocked: isLocked),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Set<int> _getLockedRowsForTable(String title) {
    switch (title) {
      case 'Activity':
        return _lockedActivityRows;
      case 'Addition':
        return _lockedAdditionRows;
      case 'Loss':
        return _lockedLossRows;
      case 'Water-based':
        return _lockedWaterRows;
      case 'Oil-based':
        return _lockedOilRows;
      case 'Synthetic':
        return _lockedSyntheticRows;
      default:
        return {};
    }
  }

  // ======================================================
  // COMMON UI PARTS - FIXED
  // ======================================================
  Widget _sectionHeader(String text, IconData icon, Gradient gradient) {
    return Container(
      height: 40,
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
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
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

  Widget _headerRow(List<String> labels, List<double> widths) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.tableHeadColor.withOpacity(0.9),
            AppTheme.tableHeadColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isLast = i == labels.length - 1;
          return Container(
            width: widths[i],
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              border: Border(
                right: isLast 
                  ? BorderSide.none
                  : BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
              ),
            ),
            child: Center(
              child: Text(
                labels[i],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _numCell(int row) {
    return SizedBox(
      width: 50,
      child: Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.secondaryGradient,
          ),
          child: Center(
            child: Text(
              '${row + 1}',
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

  Widget _editCell(double width, TextEditingController controller, {bool isLocked = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        readOnly: isLocked,
        style: TextStyle(
          fontSize: 12,
          color: isLocked ? Colors.grey : AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          filled: isLocked,
          fillColor: isLocked ? Colors.grey.shade100 : Colors.transparent,
        ),
      ),
    );
  }

  // ======================================================
  // FOOTER BUTTONS
  // ======================================================
  Widget _footerButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              // Close functionality
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Close',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              // Save functionality
              _saveData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 2,
            ),
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveTableData(String tableTitle) async {
    try {
      List<String> newData = [];
      List<TextEditingController> controllers = [];
      Set<int> lockedRows = {};

      switch (tableTitle) {
        case 'Activity':
          controllers = _activityControllers;
          lockedRows = _lockedActivityRows;
          break;
        case 'Addition':
          controllers = _additionControllers;
          lockedRows = _lockedAdditionRows;
          break;
        case 'Loss':
          controllers = _lossControllers;
          lockedRows = _lockedLossRows;
          break;
        case 'Water-based':
          controllers = _waterControllers;
          lockedRows = _lockedWaterRows;
          break;
        case 'Oil-based':
          controllers = _oilControllers;
          lockedRows = _lockedOilRows;
          break;
        case 'Synthetic':
          controllers = _syntheticControllers;
          lockedRows = _lockedSyntheticRows;
          break;
      }

      // Collect only new (unlocked) data
      for (int i = 0; i < controllers.length; i++) {
        if (!lockedRows.contains(i) && controllers[i].text.trim().isNotEmpty) {
          newData.add(controllers[i].text.trim());
        }
      }

      if (newData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No new data to save'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      Map<String, dynamic> result;
      if (newData.length == 1) {
        // Single item
        switch (tableTitle) {
          case 'Activity':
            result = await _controller.addActivities([ActivityItem(description: newData[0])]);
            break;
          case 'Addition':
            result = await _controller.addAdditions([AdditionItem(name: newData[0])]);
            break;
          case 'Loss':
            result = await _controller.addLosses([LossItem(name: newData[0])]);
            break;
          case 'Water-based':
            result = await _controller.addWaterBased([WaterBasedItem(name: newData[0])]);
            break;
          case 'Oil-based':
            result = await _controller.addOilBased([OilBasedItem(name: newData[0])]);
            break;
          case 'Synthetic':
            result = await _controller.addSynthetic([SyntheticItem(name: newData[0])]);
            break;
          default:
            return;
        }
      } else {
        // Bulk items
        switch (tableTitle) {
          case 'Activity':
            result = await _controller.addActivities(newData.map((e) => ActivityItem(description: e)).toList());
            break;
          case 'Addition':
            result = await _controller.addAdditions(newData.map((e) => AdditionItem(name: e)).toList());
            break;
          case 'Loss':
            result = await _controller.addLosses(newData.map((e) => LossItem(name: e)).toList());
            break;
          case 'Water-based':
            result = await _controller.addWaterBased(newData.map((e) => WaterBasedItem(name: e)).toList());
            break;
          case 'Oil-based':
            result = await _controller.addOilBased(newData.map((e) => OilBasedItem(name: e)).toList());
            break;
          case 'Synthetic':
            result = await _controller.addSynthetic(newData.map((e) => SyntheticItem(name: e)).toList());
            break;
          default:
            return;
        }
      }

      if (result['success'] == true) {
        // Lock the saved rows
        for (int i = 0; i < controllers.length; i++) {
          if (!lockedRows.contains(i) && controllers[i].text.trim().isNotEmpty) {
            switch (tableTitle) {
              case 'Activity':
                _lockedActivityRows.add(i);
                break;
              case 'Addition':
                _lockedAdditionRows.add(i);
                break;
              case 'Loss':
                _lockedLossRows.add(i);
                break;
              case 'Water-based':
                _lockedWaterRows.add(i);
                break;
              case 'Oil-based':
                _lockedOilRows.add(i);
                break;
              case 'Synthetic':
                _lockedSyntheticRows.add(i);
                break;
            }
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Data saved successfully'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Failed to save data'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving data: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _saveData() {
    // Collect all data from text controllers
    final Map<String, List<String>> data = {
      'Activity': activity.map((c) => c.text).toList(),
      'Addition': addition.map((c) => c.text).toList(),
      'Loss': loss.map((c) => c.text).toList(),
      'Water-based': water.map((c) => c.text).toList(),
      'Oil-based': oil.map((c) => c.text).toList(),
      'Synthetic': synthetic.map((c) => c.text).toList(),
    };

    // TODO: Implement actual save logic
    print('Saving data: $data');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data saved successfully'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
