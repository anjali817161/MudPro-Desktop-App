import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/operators_model.dart';
import '../../../auth_repo/auth_repo.dart';

class OperatorController extends GetxController {
  final _repo = AuthRepository();

  RxBool isSaving = false.obs;

  /// SAVE FROM UI CONTROLLERS
  Future<void> saveOperators(
      List<List<TextEditingController>> uiControllers) async {
    isSaving.value = true;

    final List<OperatorModel> list = [];

    for (var row in uiControllers) {
      // skip empty rows
      if (row[0].text.trim().isEmpty) continue;

      list.add(
        OperatorModel(
          company: row[0].text.trim(),
          contact: row[1].text.trim(),
          address: row[2].text.trim(),
          phone: row[3].text.trim(),
          email: row[4].text.trim(),
          logoUrl: row[5].text.trim(), 
        ),
      );
    }

    if (list.isEmpty) {
      Get.snackbar("Error", "No operator data to save");
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
    } else {
      Get.snackbar("Error", res['message'] ?? "Save failed");
    }

    isSaving.value = false;
  }
}
