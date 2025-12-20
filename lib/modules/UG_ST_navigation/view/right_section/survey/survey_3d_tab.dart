import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'package:mudpro_desktop_app/modules/UG_ST_navigation/model/UG_ST_model.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';

class Survey3DChart extends StatefulWidget {
  final List<Well3DPoint> points;

  const Survey3DChart({super.key, required this.points});

  static final demoPoints = <Well3DPoint>[
    Well3DPoint(0, 0, 0),
    Well3DPoint(150, 0, 300),
    Well3DPoint(300, 100, 600),
    Well3DPoint(450, 200, 900),
    Well3DPoint(550, 350, 1200),
    Well3DPoint(600, 500, 1500),
    Well3DPoint(620, 650, 1800),
    Well3DPoint(600, 800, 2100),
    Well3DPoint(550, 950, 2400),
    Well3DPoint(450, 1100, 2700),
    Well3DPoint(300, 1250, 3000),
    Well3DPoint(150, 1400, 3300),
    Well3DPoint(0, 1500, 3600),
  ];

  @override
  State<Survey3DChart> createState() => _Survey3DChartState();
}

class _Survey3DChartState extends State<Survey3DChart> {
  double rotX = -0.6;
  double rotY = 0.8;
  double zoom = 0.8;
  double panX = 0.0;
  double panY = 0.0;

  @override
  Widget build(BuildContext context) {
    final data = widget.points.isNotEmpty
        ? widget.points
        : Survey3DChart.demoPoints;

    return Container(
      decoration: AppTheme.elevatedCardDecoration.copyWith(
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // ================= HEADER =================
          Row(
            children: [
              Icon(Icons.rotate_90_degrees_ccw, size: 20, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Text(
                "3D Well Trajectory",
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "3D View",
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ================= CHART INFO =================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: AppTheme.infoColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Interactive 3D visualization of well trajectory with X, Y, Z coordinates",
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.rotate_right, size: 12, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        "${(rotX * 180 / 3.14).toStringAsFixed(0)}°, ${(rotY * 180 / 3.14).toStringAsFixed(0)}°",
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ================= 3D CHART CONTAINER =================
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Stack(
                children: [
                  // 3D Chart
                  CustomPaint(
                    painter: _Well3DPainter(
                      points: data,
                      rotX: rotX,
                      rotY: rotY,
                      zoom: zoom,
                      panX: panX,
                      panY: panY,
                    ),
                    size: Size.infinite,
                  ),

                  // Axis Labels
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Row(
                      children: [
                        _axisLabel("X: East/West", AppTheme.accentColor),
                        const SizedBox(width: 8),
                        _axisLabel("Y: North/South", AppTheme.secondaryColor),
                        const SizedBox(width: 8),
                        _axisLabel("Z: Depth", AppTheme.primaryColor),
                      ],
                    ),
                  ),

                  // Coordinates Display
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Scale: 1:1000 • Points: ${data.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                  // ===== ENHANCED ROTATION CONTROLS =====
                  Positioned(
                    right: 10,
                    top: 50,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Rotation Controls
                          Text(
                            "Rotation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // X Rotation
                          Row(
                            children: [
                              _controlButton(
                                Icons.arrow_upward,
                                "X-",
                                () => setState(() {
                                  rotX = (rotX - 0.2) % (2 * 3.14159);
                                  _constrainChart();
                                }),
                              ),
                              const SizedBox(width: 4),
                              _controlButton(
                                Icons.arrow_downward,
                                "X+",
                                () => setState(() {
                                  rotX = (rotX + 0.2) % (2 * 3.14159);
                                  _constrainChart();
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          
                          // Y Rotation
                          Row(
                            children: [
                              _controlButton(
                                Icons.arrow_back,
                                "Y-",
                                () => setState(() {
                                  rotY = (rotY - 0.2) % (2 * 3.14159);
                                  _constrainChart();
                                }),
                              ),
                              const SizedBox(width: 4),
                              _controlButton(
                                Icons.arrow_forward,
                                "Y+",
                                () => setState(() {
                                  rotY = (rotY + 0.2) % (2 * 3.14159);
                                  _constrainChart();
                                }),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            width: 60,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 12),
                          
                          // Zoom Controls
                          Text(
                            "Zoom",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          Row(
                            children: [
                              _controlButton(
                                Icons.zoom_in,
                                "",
                                () => setState(() {
                                  zoom = (zoom * 1.2).clamp(0.1, 3.0);
                                  _constrainChart();
                                }),
                              ),
                              const SizedBox(width: 4),
                              _controlButton(
                                Icons.zoom_out,
                                "",
                                () => setState(() {
                                  zoom = (zoom / 1.2).clamp(0.1, 3.0);
                                  _constrainChart();
                                }),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            width: 60,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 12),
                          
                          // Reset Button
                          _controlButton(
                            Icons.refresh,
                            "Reset",
                            () => setState(() {
                              rotX = -0.6;
                              rotY = 0.8;
                              zoom = 0.8;
                              panX = 0.0;
                              panY = 0.0;
                            }),
                            color: AppTheme.warningColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pan Controls (for touch/mouse)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.grab,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            panX += details.delta.dx * 0.01;
                            panY += details.delta.dy * 0.01;
                            _constrainChart();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.pan_tool,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ),

          const SizedBox(height: 16),

          // ================= VIEW PRESETS =================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "View Presets",
                  style: AppTheme.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _viewPresetButton("Top View", Icons.north, () => setState(() {
                      rotX = 0;
                      rotY = 0;
                      zoom = 0.8;
                    })),
                    _viewPresetButton("Side View", Icons.east, () => setState(() {
                      rotX = 0;
                      rotY = 1.57;
                      zoom = 0.8;
                    })),
                    _viewPresetButton("Front View", Icons.south, () => setState(() {
                      rotX = 1.57;
                      rotY = 0;
                      zoom = 0.8;
                    })),
                    _viewPresetButton("Isometric", Icons.rotate_90_degrees_ccw, () => setState(() {
                      rotX = -0.6;
                      rotY = 0.8;
                      zoom = 0.8;
                    })),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ================= COORDINATE SYSTEM =================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.infoColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.infoColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.compass_calibration, size: 16, color: AppTheme.infoColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "X: East-West (+E/-W) | Y: North-South (+N/-S) | Z: Vertical Depth (TVD)",
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }

  Widget _axisLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _controlButton(IconData icon, String label, VoidCallback onPressed, {Color? color}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color ?? AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: label.isEmpty
              ? Icon(icon, size: 14, color: Colors.white)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 12, color: Colors.white),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _viewPresetButton(String label, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppTheme.primaryColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _constrainChart() {
    // Keep zoom within reasonable bounds
    zoom = zoom.clamp(0.1, 3.0);
    
    // Keep pan within bounds
    panX = panX.clamp(-100.0, 100.0);
    panY = panY.clamp(-100.0, 100.0);
  }
}

class _Well3DPainter extends CustomPainter {
  final List<Well3DPoint> points;
  final double rotX;
  final double rotY;
  final double zoom;
  final double panX;
  final double panY;

  _Well3DPainter({
    required this.points,
    required this.rotX,
    required this.rotY,
    required this.zoom,
    required this.panX,
    required this.panY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2 + panX, size.height / 2 + panY);
    
    // Calculate bounds to ensure chart stays within canvas
    final bounds = Rect.fromCenter(
      center: center,
      width: size.width * 0.8,
      height: size.height * 0.8,
    );

    // Create transformation matrix for 3D rotation
    final transform = vm.Matrix4.identity()
      ..rotateX(rotX)
      ..rotateY(rotY)
      ..scale(zoom);

    /// ===== BACKGROUND GRID =====
    _drawGrid(canvas, size, center);

    /// ===== 3D AXES =====
    _draw3DAxes(canvas, size, center, transform);

    /// ===== WELL PATH =====
    _drawWellPath(canvas, size, center, transform, bounds);

    /// ===== START AND END POINTS =====
    if (points.isNotEmpty) {
      _drawSpecialPoints(canvas, size, center, transform, bounds);
    }
  }

  void _drawGrid(Canvas canvas, Size size, Offset center) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Vertical lines
    for (int i = -10; i <= 10; i++) {
      final x = center.dx + i * 40;
      if (x >= 0 && x <= size.width) {
        canvas.drawLine(
          Offset(x, 0),
          Offset(x, size.height),
          gridPaint,
        );
      }
    }

    // Horizontal lines
    for (int i = -10; i <= 10; i++) {
      final y = center.dy + i * 40;
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          gridPaint,
        );
      }
    }
  }

  void _draw3DAxes(Canvas canvas, Size size, Offset center, vm.Matrix4 transform) {
    final axisLength = 80.0;
    
    // X Axis (Red - East/West)
    final xAxis = transform.transform3(vm.Vector3(axisLength, 0, 0));
    canvas.drawLine(
      center,
      Offset(center.dx + xAxis.x, center.dy + xAxis.y),
      Paint()
        ..color = AppTheme.accentColor
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(center.dx + xAxis.x, center.dy + xAxis.y),
      3,
      Paint()..color = AppTheme.accentColor,
    );

    // Y Axis (Green - North/South)
    final yAxis = transform.transform3(vm.Vector3(0, axisLength, 0));
    canvas.drawLine(
      center,
      Offset(center.dx + yAxis.x, center.dy + yAxis.y),
      Paint()
        ..color = AppTheme.secondaryColor
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(center.dx + yAxis.x, center.dy + yAxis.y),
      3,
      Paint()..color = AppTheme.secondaryColor,
    );

    // Z Axis (Blue - Depth)
    final zAxis = transform.transform3(vm.Vector3(0, 0, axisLength));
    canvas.drawLine(
      center,
      Offset(center.dx + zAxis.x, center.dy + zAxis.y),
      Paint()
        ..color = AppTheme.primaryColor
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(center.dx + zAxis.x, center.dy + zAxis.y),
      3,
      Paint()..color = AppTheme.primaryColor,
    );
  }

  void _drawWellPath(Canvas canvas, Size size, Offset center, vm.Matrix4 transform, Rect bounds) {
    final pathPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    List<Offset> screenPoints = [];

    for (int i = 0; i < points.length; i++) {
      final p = points[i];

      // Normalize values for better scaling
      final v = vm.Vector3(
        p.x / 50, // Scale factor for X
        p.y / 50, // Scale factor for Y
        -p.z / 50, // Invert Z for depth (negative is down)
      );

      final tv = transform.transform3(v);
      
      // Apply scaling and ensure within bounds
      final screenX = center.dx + tv.x * zoom * 50;
      final screenY = center.dy + tv.y * zoom * 50;
      
      // Clamp to bounds
      final clampedX = screenX.clamp(bounds.left, bounds.right);
      final clampedY = screenY.clamp(bounds.top, bounds.bottom);
      
      final screen = Offset(clampedX, clampedY);
      screenPoints.add(screen);

      if (i == 0) {
        path.moveTo(screen.dx, screen.dy);
      } else {
        path.lineTo(screen.dx, screen.dy);
      }

      // Draw points with gradient color based on depth
      final depthRatio = p.z / 4000;
      final pointColor = Color.lerp(
        AppTheme.secondaryColor,
        AppTheme.primaryColor,
        depthRatio.clamp(0.0, 1.0),
      )!;

      canvas.drawCircle(
        screen,
        i == 0 || i == points.length - 1 ? 5 : 3,
        Paint()
          ..color = pointColor
          ..style = PaintingStyle.fill,
      );
      
      canvas.drawCircle(
        screen,
        i == 0 || i == points.length - 1 ? 5 : 3,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
      );
    }

    // Draw the path
    canvas.drawPath(path, pathPaint);

    // Add gradient fill below path
    if (screenPoints.length > 1) {
      final fillPath = Path()..addPath(path, Offset.zero);
      fillPath.lineTo(screenPoints.last.dx, bounds.bottom);
      fillPath.lineTo(screenPoints.first.dx, bounds.bottom);
      fillPath.close();
      canvas.drawPath(fillPath, fillPaint);
    }
  }

  void _drawSpecialPoints(Canvas canvas, Size size, Offset center, vm.Matrix4 transform, Rect bounds) {
    // Start Point
    final first = points.first;
    final v1 = vm.Vector3(first.x / 50, first.y / 50, -first.z / 50);
    final tv1 = transform.transform3(v1);
    final startPoint = Offset(
      (center.dx + tv1.x * zoom * 50).clamp(bounds.left, bounds.right),
      (center.dy + tv1.y * zoom * 50).clamp(bounds.top, bounds.bottom),
    );

    // End Point
    final last = points.last;
    final v2 = vm.Vector3(last.x / 50, last.y / 50, -last.z / 50);
    final tv2 = transform.transform3(v2);
    final endPoint = Offset(
      (center.dx + tv2.x * zoom * 50).clamp(bounds.left, bounds.right),
      (center.dy + tv2.y * zoom * 50).clamp(bounds.top, bounds.bottom),
    );

    // Draw start point label
    canvas.drawCircle(
      startPoint,
      6,
      Paint()..color = AppTheme.successColor,
    );
    canvas.drawCircle(
      startPoint,
      6,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    // Draw end point label
    canvas.drawCircle(
      endPoint,
      6,
      Paint()..color = AppTheme.errorColor,
    );
    canvas.drawCircle(
      endPoint,
      6,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    // Add text labels
    _drawTextWithBackground(
      canvas,
      "Start",
      startPoint.translate(10, -10),
      AppTheme.successColor,
    );
    _drawTextWithBackground(
      canvas,
      "Target",
      endPoint.translate(10, -10),
      AppTheme.errorColor,
    );
  }

  void _drawTextWithBackground(Canvas canvas, String text, Offset position, Color color) {
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.w600,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Draw background
    final bgRect = Rect.fromCenter(
      center: position,
      width: textPainter.width + 8,
      height: textPainter.height + 4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bgRect, const Radius.circular(4)),
      Paint()..color = color.withOpacity(0.8),
    );

    // Draw text
    textPainter.paint(
      canvas,
      position.translate(-textPainter.width / 2, -textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _Well3DPainter old) =>
      old.rotX != rotX ||
      old.rotY != rotY ||
      old.zoom != zoom ||
      old.panX != panX ||
      old.panY != panY ||
      old.points != points;
}