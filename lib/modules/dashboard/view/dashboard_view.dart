import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/editable_table.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/left_report_list.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/lock_bar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/primary_tabbar.dart';
import 'package:mudpro_desktop_app/modules/dashboard/widgets/secondary_tabbar.dart';
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
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF7FAFC), Color(0xffEDF2F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Top Header with shadow
            Material(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              child: TopHeaderBar(),
            ),
            
            // Primary Tab Bar
            Material(
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.05),
              child: PrimaryTabBar(),
            ),
            
            // Secondary Tab Bar
            Material(
              elevation: 1,
              shadowColor: Colors.black.withOpacity(0.03),
              child: SecondaryTabBar(),
            ),
            
            // Main Content Area
            Expanded(
              child: Row(
                children: [
                  // Left Sidebar with shadow
                  Material(
                    elevation: 2,
                    shadowColor: Colors.black.withOpacity(0.05),
                    child: LeftReportTree(),
                  ),
                  
                  // Main Content
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Color(0xffFAFBFC)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Obx(() {
                        if (c.selectedNodeId.value == 'UG') {
                          return _buildAnimatedTransition(UGRightPanel());
                        } else if (c.selectedNodeId.value == 'UG-0293-ST') {
                          return _buildAnimatedTransition(RightPanel());
                        } else {
                          return _buildAnimatedTransition(
                            Column(
                              children: [
                                Material(
                                  elevation: 1,
                                  shadowColor: Colors.black.withOpacity(0.03),
                                  child: SectionNavBar(),
                                ),
                                
                                Material(
                                  elevation: 1,
                                  shadowColor: Colors.black.withOpacity(0.02),
                                  child: LockBar(),
                                ),
                                
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: WellTabContent(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTransition(Widget child) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}