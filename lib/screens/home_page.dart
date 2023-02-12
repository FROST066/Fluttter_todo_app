import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'list_tasks_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.selectedIndex});
  int? selectedIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _list = [
    const Pie_Chart(),
    const ListTasksScreen(),
    const Pie_Chart()
  ];
  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: "Statistique", icon: Icon(Icons.stacked_bar_chart_sharp)),
          BottomNavigationBarItem(
              label: "Liste des taches",
              icon: Icon(Icons.stacked_bar_chart_sharp)),
          BottomNavigationBarItem(label: "A propos", icon: Icon(Icons.info))
        ],
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          selectedIndex = value;
        }),
      ),
    );
  }
}

class Pie_Chart extends StatefulWidget {
  const Pie_Chart({super.key});

  @override
  State<Pie_Chart> createState() => _Pie_ChartState();
}

class _Pie_ChartState extends State<Pie_Chart> {
  Map<String, double> dataMap = {"Entreé": 100, "Sortie": 70, "En stock": 30};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistiques"),
        centerTitle: true,
      ),
      body: Center(
        child: PieChart(
            animationDuration: const Duration(milliseconds: 1000),
            dataMap: dataMap,
            colorList: const [Colors.green, Colors.red, Colors.blue],
            chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,

                // showChartValuesOutside: true,
                decimalPlaces: 0,
                chartValueStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            initialAngleInDegree: 90,
            chartLegendSpacing: 20,
            legendOptions: const LegendOptions(
              // showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      ),
    );
  }
}
