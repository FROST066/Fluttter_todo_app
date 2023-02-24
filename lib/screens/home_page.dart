import 'package:blog/utils/constants.dart';
import 'package:blog/widgets/BarChart.dart';
import 'package:flutter/material.dart';
import 'list_tasks_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.selectedIndex});
  int? selectedIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> dataMap = {
    "Toutes les tâches": 200,
    "Tâches non commencées": 70,
    "Tâches en cours": 30,
    "Tâches finies": 70,
    "Tâches finies avec retard": 30
  };
  List<Widget> _list = [];
  late int selectedIndex;
  @override
  void initState() {
    _list = [
      CustomChart(dataMap: dataMap),
      const ListTasksScreen(),
      CustomChart(dataMap: dataMap),
    ];
    selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: appBlue,
        items: const [
          BottomNavigationBarItem(
              label: "Statistique", icon: Icon(Icons.stacked_bar_chart_sharp)),
          BottomNavigationBarItem(
              label: "Liste des taches", icon: Icon(Icons.list)),
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
