import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MudController extends GetxController {
  final samples = ['1', '2', '3', 'Plan-L', 'Plan-H'];

  /// LEFT TABLE DATA
  final propertyTable = <String, List<RxString>>{}.obs;

  /// RIGHT TABLE DATA
  final rheologyTable = <String, List<RxString>>{}.obs;

  var rheologyModel = 'Bingham'.obs;

  final fluidnameController = TextEditingController();

  @override
  void onInit() {
    _initPropertyTable();
    _initRheologyTable();
    super.onInit();
  }

  void _initPropertyTable() {
    final rows = [
      'Description',
      'Sample from',
      'Time Sample Taken (hh:mm)',
      'Depth (m)',
      'MW (ppg)',
      'Funnel Visc. (sec/qt)',
      'PV (cp)',
      'YP (lb/100ft²)',
    ];

    for (var r in rows) {
      propertyTable[r] =
          List.generate(samples.length, (_) => ''.obs);
    }
  }

  void _initRheologyTable() {
    _updateRheologyRows();
  }

  void changeModel(String model) {
    rheologyModel.value = model;
    _updateRheologyRows();
  }

  void _updateRheologyRows() {
    final rows = rheologyModel.value == 'Bingham'
        ? ['600', '300', '200', '100', 'PV', 'YP']
        : rheologyModel.value == 'Power Law'
            ? ['600', '300', '200', 'n', 'K']
            : ['600', '300', '200', 'YP', 'n', 'K'];

    rheologyTable.clear();
    for (var r in rows) {
      rheologyTable[r] =
          List.generate(samples.length, (_) => ''.obs);
    }
  }
}
