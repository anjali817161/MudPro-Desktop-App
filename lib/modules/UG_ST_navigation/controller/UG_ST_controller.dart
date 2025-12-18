import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UgStController extends GetxController {
  var selectedWellTab = 0.obs; // 0 = Well
  var isLocked = true.obs;

  void switchWellTab(int index) {
    selectedWellTab.value = index;
  }

  void toggleLock() {
    isLocked.value = !isLocked.value;
  }
}
