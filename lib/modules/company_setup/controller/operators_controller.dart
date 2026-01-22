import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/operators_model.dart';
import '../../../auth_repo/auth_repo.dart';

class OperatorController extends GetxController {
  final _repo = AuthRepository();

  // Observable list of operators
  final RxList<OperatorModel> operators = <OperatorModel>[].obs;
  final RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOperators();
  }

  /// SAVE FROM UI CONTROLLERS
  Future<void> saveOperators(
      List<List<TextEditingController>> uiControllers) async {
    isSaving.value = true;

    final List<OperatorModel> list = [];

    for (var row in uiControllers) {
      // skip empty rows
      if (row[0].text.trim().isEmpty) continue;

      final newOperator = OperatorModel(
        company: row[0].text.trim(),
        contact: row[1].text.trim(),
        address: row[2].text.trim(),
        phone: row[3].text.trim(),
        email: row[4].text.trim(),
        logoUrl: row[5].text.trim(),
      );

      // Check if this operator already exists in the fetched operators list
      final exists = operators.any((existing) =>
          existing.company == newOperator.company &&
          existing.contact == newOperator.contact &&
          existing.address == newOperator.address &&
          existing.phone == newOperator.phone &&
          existing.email == newOperator.email);

      if (!exists) {
        list.add(newOperator);
      }
    }

    if (list.isEmpty) {
      Get.snackbar("Info", "No new operator data to save");
      isSaving.value = false;
      return;
    }

    final body = list.map((e) => e.toJson()).toList();
    final res = await _repo.saveOperators(body);

    print("response body====${body}");
    print("response res====${res}");
    print(
        "response statuscode====${res['statusCode']}"
    );

    if (res['success'] == true || res['statusCode'] == 200) {
      Get.snackbar("Success", "Operators saved successfully");
      // Refresh the operators list after saving
      await fetchOperators();
    } else {
      Get.snackbar("Error", res['message'] ?? "Save failed");
    }

    isSaving.value = false;
  }

  /// FETCH OPERATORS
  Future<void> fetchOperators() async {
    isLoading.value = true;

    final result = await _repo.getOperators();

    if (result['success'] == true) {
      operators.value = (result['data'] as List<dynamic>?)
          ?.map((item) => OperatorModel.fromJson(item as Map<String, dynamic>))
          .toList() ?? [];
    } else {
      Get.snackbar("Error", result['message'] ?? "Failed to fetch operators");
    }

    isLoading.value = false;
  }
}
