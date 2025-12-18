import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/editable_table.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/left_report_list.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/lock_bar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/primary_tabbar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/secondary_tabbar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/top_info_bar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/well_tab_content.dart';
import 'package:mudpro_desktop_app/modules/UG/controller/UG_controller.dart';
import 'package:mudpro_desktop_app/modules/UG/right_pannel/right_pannel_view.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/controller/UG_ST_controller.dart';
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/view/pannel_switcher.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/top_bar.dart';
import '../widgets/section_navbar.dart';

// ==================== MAIN VIEW ====================
class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final c = Get.put(DashboardController());
  final ugStC = Get.put(UgStController());
  final ugC = Get.put(UgController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          TopHeaderBar(),
          PrimaryTabBar(),
          SecondaryTabBar(),
          Expanded(
            child: Row(
              children: [
                LeftReportTree(),
                Expanded(
                  child: Obx(() {
                    if (c.selectedNodeId.value == 'UG') {
                      return UGRightPanel();
                    } else if (c.selectedNodeId.value == 'UG-0293-ST') {
                      return RightPanel();
                    } else {
                      return Column(
                        children: [
                          SectionNavBar(),

                          LockBar(),
                          Expanded(child: WellTabContent()),
                        ],
                      );
                    }
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
