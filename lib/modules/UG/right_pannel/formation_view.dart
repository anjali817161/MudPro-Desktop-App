import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UG_controller.dart';

class FormationView extends StatelessWidget {
  FormationView({super.key});
  final c = Get.find<UgController>();

  static const rowH = 28.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [

      
         // ================= TOP BAR =================
Container(
  height: 34,
  padding: const EdgeInsets.symmetric(horizontal: 8),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black26),
    color: const Color(0xffF2F2F2),
  ),
  child: Row(
    children: [

      // CHECKBOX
      Obx(() => Checkbox(
            value: c.poreFromTop.value,
            onChanged: c.isLocked.value
                ? null
                : (v) => c.poreFromTop.value = v!,
            visualDensity: VisualDensity.compact,
          )),
      const Text(
        'Pore and Fracture (from top down)',
        style: TextStyle(fontSize: 11),
      ),

      const SizedBox(width: 20),

      // DROPDOWN
      Obx(() => SizedBox(
            height: 26,
            child: DropdownButton<String>(
              value: c.formationMode.value,
              items: const [
                DropdownMenuItem(value: 'Density', child: Text('Density', style: TextStyle(fontSize: 12),)),
                DropdownMenuItem(value: 'Gradient', child: Text('Gradient', style: TextStyle(fontSize: 12))),
                DropdownMenuItem(value: 'Pressure', child: Text('Pressure', style: TextStyle(fontSize: 12))),
              ],
              onChanged: c.isLocked.value
                  ? null
                  : (v) => c.formationMode.value = v!,
              isDense: true,
            ),
          )),

      const Spacer(),

      // ⚠️ WARNING BUTTON
      IconButton(
        icon: const Icon(Icons.warning_amber_rounded,
            size: 18, color: Colors.orange),
        onPressed: () => _showFormationWarning(context),
      ),
    ],
  ),
),


          const SizedBox(height: 4),

          // ================= TABLE =================
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Column(
                children: [
                  _header(),
                  Expanded(child: _body()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Column(
      children: [
        Container(
          height: 48,
          color: const Color.fromARGB(255, 225, 223, 223),
          child: Row(
            children: _cells([
              _h('#', 1),
              _h('Description', 3),
              _h('Btm TVD\n(m)', 2),
              _group('Pore', ['ppg', 'psi/ft', 'psi']),
              _group('Frac.', ['ppg', 'psi/ft', 'psi']),
              _h('Lithology', 3),
            ]),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  // ================= BODY =================
  Widget _body() {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (_, i) {
        final row = i < c.formations.length ? c.formations[i] : null;

        return Container(
          height: rowH,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          child: Row(
            children: _cells([
              _text('${i + 1}', 1),
              _edit(row?.description, 3),
              _edit(row?.tvd, 2),
              _edit(row?.porePpg, 1),
              _edit(row?.poreGrad, 1),
              _edit(row?.porePsi, 1),
              _edit(row?.fracPpg, 1),
              _edit(row?.fracGrad, 1),
              _edit(row?.fracPsi, 1),
              _text('No image data', 3),
            ]),
          ),
        );
      },
    );
  }

  // ================= HELPERS =================
  List<Widget> _cells(List<Widget> w) {
    final r = <Widget>[];
    for (int i = 0; i < w.length; i++) {
      r.add(w[i]);
      if (i < w.length - 1) {
        r.add(const VerticalDivider(width: 1, color: Colors.black12));
      }
    }
    return r;
  }

  Widget _h(String t, int flex) => Expanded(
    flex: flex,
    child: Center(
      child: Text(t,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _group(String title, List<String> subs) {
  return Expanded(
    flex: subs.length,
    child: Column(
      children: [
        SizedBox(
          height: 48 / 2,
          child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),

        const Divider(height: 1, thickness: 1),

        SizedBox(
          height: rowH / 2,
          child: Row(
            children: subs
                .map((e) => Expanded(
                      child: Center(
                        child:
                            Text(e, style: const TextStyle(fontSize: 10)),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}


  void _showFormationWarning(BuildContext context) {
  Get.dialog(
    Dialog(
      child: Container(
        width: 520,
        height: 260,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

            // HEADER
            Container(
              height: 32,
              color: const Color(0xff2F5597),
              alignment: Alignment.center,
              child: const Text(
                'Warning',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // TABLE
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Column(
                  children: [

                    // TABLE HEADER
                    Container(
                      height: 28,
                      color: const Color(0xffE6E6E6),
                      child: Row(
                        children: const [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text('Title',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              )),
                          VerticalDivider(width: 1),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text('Message',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // ROWS
                    _warningRow(
                      'Pad - Formation',
                      'Formation table should not be empty.',
                    ),
                    _warningRow(
                      'Pad - Formation',
                      'Reservoir Pressure table should not be empty.',
                    ),
                  ],
                ),
              ),
            ),

            // FOOTER
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.back(),
                child: const Text('Close'),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _warningRow(String title, String msg) {
  return Container(
    height: 28,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black12)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(title, style: const TextStyle(fontSize: 11)),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(msg, style: const TextStyle(fontSize: 11)),
          ),
        ),
      ],
    ),
  );
}


  Widget _text(String t, int flex) => Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(t, style: const TextStyle(fontSize: 11)),
    ),
  );

  Widget _edit(RxString? v, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Obx(() => c.isLocked.value || v == null
            ? Text(v?.value ?? '',
                style: const TextStyle(fontSize: 11))
            : TextField(
                controller: TextEditingController(text: v.value),
                onChanged: (x) => v.value = x,
                style: const TextStyle(fontSize: 11),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              )),
      ),
    );
  }
}
