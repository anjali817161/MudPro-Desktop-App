import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/engineering_tools_controller.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class HydraulicsAnnularVelocity extends StatelessWidget {
  const HydraulicsAnnularVelocity({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EngineeringToolsController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800;
        
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Description
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.infoColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.infoColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: AppTheme.infoColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Calculate annular velocity based on pump output, hole size, and pipe OD",
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Calculator Section - Made scrollable
              Expanded(
                child: isSmallScreen
                    ? _buildMobileLayout(c)
                    : _buildDesktopLayout(c),
              ),

              const SizedBox(height: 16),

              // Formula Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Formula Used:",
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "AV = (24.51 × Pump Output) ÷ (Hole Size² - Pipe OD²)",
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Where: AV = Annular Velocity (ft/min), Pump Output (bpm), Hole Size & Pipe OD (inches)",
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(EngineeringToolsController c) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Panel - Wider with row layout
          Container(
            width: 450, // Increased width
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Input Parameters",
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Input fields with labels and text fields in rows
                _inputFieldWithRow("Pump Output", "bpm", c.pumpOutput, "567"),
                const SizedBox(height: 16),
                _inputFieldWithRow("Hole Size", "inches", c.holeSize, "456"),
                const SizedBox(height: 16),
                _inputFieldWithRow("Pipe OD", "inches", c.pipeOD, "45"),
                
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: c.calculateAnnularVelocity,
                        style: AppTheme.primaryButtonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate, size: 14),
                            const SizedBox(width: 6),
                            Text("Calculate", style: AppTheme.caption.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: c.resetAnnularVelocity,
                      style: AppTheme.secondaryButtonStyle,
                      child: Text("Reset", style: AppTheme.caption),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Result Panel - Flexible width
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Obx(() {
                final result = c.annularVelocity.value;
                final hasResult = result != null;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Calculation Result",
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    if (!hasResult)
                      Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calculate_outlined,
                              size: 48,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Enter values and click Calculate",
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.successColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.successColor.withOpacity(0.2)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Annular Velocity",
                                  style: AppTheme.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${result.toStringAsFixed(2)} ft/min",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.successColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.info, size: 14, color: AppTheme.infoColor),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "Based on your inputs",
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Input Summary",
                                  style: AppTheme.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _inputSummaryRow("Pump Output", "${c.pumpOutput.value} bpm"),
                                const SizedBox(height: 8),
                                _inputSummaryRow("Hole Size", "${c.holeSize.value} inches"),
                                const SizedBox(height: 8),
                                _inputSummaryRow("Pipe OD", "${c.pipeOD.value} inches"),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(EngineeringToolsController c) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Input Panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Input Parameters",
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                _inputFieldWithRow("Pump Output", "bpm", c.pumpOutput, "567"),
                const SizedBox(height: 16),
                _inputFieldWithRow("Hole Size", "inches", c.holeSize, "456"),
                const SizedBox(height: 16),
                _inputFieldWithRow("Pipe OD", "inches", c.pipeOD, "45"),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: c.calculateAnnularVelocity,
                        style: AppTheme.primaryButtonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate, size: 14),
                            const SizedBox(width: 6),
                            Text("Calculate", style: AppTheme.caption.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: c.resetAnnularVelocity,
                      style: AppTheme.secondaryButtonStyle,
                      child: Text("Reset", style: AppTheme.caption),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Result Panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Obx(() {
              final result = c.annularVelocity.value;
              final hasResult = result != null;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calculation Result",
                    style: AppTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (!hasResult)
                    Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calculate_outlined,
                            size: 48,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Enter values and click Calculate",
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.successColor.withOpacity(0.2)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Annular Velocity",
                                style: AppTheme.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${result.toStringAsFixed(2)} ft/min",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Input Summary",
                                style: AppTheme.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _inputSummaryRow("Pump Output", "${c.pumpOutput.value} bpm"),
                              const SizedBox(height: 8),
                              _inputSummaryRow("Hole Size", "${c.holeSize.value} inches"),
                              const SizedBox(height: 8),
                              _inputSummaryRow("Pipe OD", "${c.pipeOD.value} inches"),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _inputFieldWithRow(String label, String unit, RxString value, String example) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label and Unit in same row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTheme.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                unit,
                style: AppTheme.caption.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Input field with example
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: value.value),
                    onChanged: (v) => value.value = v,
                    keyboardType: TextInputType.number,
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.textPrimary,
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Enter value",
                      hintStyle: AppTheme.caption.copyWith(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Text(
                    "e.g. $example",
                    style: AppTheme.caption.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputSummaryRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTheme.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}