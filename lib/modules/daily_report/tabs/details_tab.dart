import 'package:flutter/material.dart';

class DetailsTabView extends StatelessWidget {
  const DetailsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              /// TOP ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: GeometryTable()),
                  SizedBox(width: 8),
                  Expanded(child: CirculationTable()),
                ],
              ),

              const SizedBox(height: 8),

              /// ANNULAR HYDRAULICS (FULL WIDTH)
              const AnnularHydraulicsTable(),

              const SizedBox(height: 8),

              /// BOTTOM ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: SolidsAnalysisTable()),
                  SizedBox(width: 8),
                  Expanded(child: BitHydraulicsTable()),
                  SizedBox(width: 8),
                  Expanded(child: VolumeTable()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget tableCard(String title, Widget table) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: Colors.grey.shade200,
          child: Text(title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: table,
        ),
      ],
    ),
  );
}

class GeometryTable extends StatelessWidget {
  const GeometryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Geometry",
      DataTable(
        columnSpacing: 12,
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("Description")),
          DataColumn(label: Text("Start (ft)")),
          DataColumn(label: Text("End (ft)")),
          DataColumn(label: Text("Vol (bbl)")),
          DataColumn(label: Text("Vol (bbl/ft)")),
        ],
        rows: List.generate(
          6,
          (i) => DataRow(cells: [
            DataCell(Text("${i + 1}")),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
          ]),
        ),
      ),
    );
  }
}

class CirculationTable extends StatelessWidget {
  const CirculationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Circulation",
      DataTable(
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("Path")),
          DataColumn(label: Text("Minutes")),
          DataColumn(label: Text("Strokes")),
        ],
        rows: List.generate(
          5,
          (i) => DataRow(cells: [
            DataCell(Text("${i + 1}")),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
          ]),
        ),
      ),
    );
  }
}

class AnnularHydraulicsTable extends StatelessWidget {
  const AnnularHydraulicsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Annular Hydraulics",
      DataTable(
        columnSpacing: 14,
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("Section (in)")),
          DataColumn(label: Text("Length (ft)")),
          DataColumn(label: Text("Vel Ann")),
          DataColumn(label: Text("Vel Crit")),
          DataColumn(label: Text("Re Ann")),
          DataColumn(label: Text("Re Crit")),
          DataColumn(label: Text("Flow")),
          DataColumn(label: Text("ECD")),
        ],
        rows: List.generate(
          6,
          (i) => DataRow(cells: List.generate(
            9,
            (j) => const DataCell(
              TextField(decoration: InputDecoration(border: InputBorder.none)),
            ),
          )),
        ),
      ),
    );
  }
}

class SolidsAnalysisTable extends StatelessWidget {
  const SolidsAnalysisTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Solids Analysis",
      DataTable(
        columns: const [
          DataColumn(label: Text("Description")),
          DataColumn(label: Text("Sample 1")),
          DataColumn(label: Text("Sample 2")),
          DataColumn(label: Text("Sample 3")),
        ],
        rows: List.generate(
          6,
          (i) => DataRow(cells: [
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            const DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
          ]),
        ),
      ),
    );
  }
}


class BitHydraulicsTable extends StatelessWidget {
  const BitHydraulicsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Bit Hydraulics",
      DataTable(
        columns: const [
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Value")),
        ],
        rows: List.generate(
          8,
          (i) => const DataRow(cells: [
            DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
          ]),
        ),
      ),
    );
  }
}


class VolumeTable extends StatelessWidget {
  const VolumeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return tableCard(
      "Volume (bbl)",
      DataTable(
        columns: const [
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Value")),
        ],
        rows: List.generate(
          8,
          (i) => const DataRow(cells: [
            DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
            DataCell(TextField(decoration: InputDecoration(border: InputBorder.none))),
          ]),
        ),
      ),
    );
  }
}
