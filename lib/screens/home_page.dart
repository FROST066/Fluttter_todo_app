import 'package:blog/utils/constants.dart';
import 'package:blog/widgets/BarChart.dart';
import 'package:flutter/material.dart';
import 'AboutUs.dart';
import 'list_tasks_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.selectedIndex});
  int? selectedIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _list = const [
    CustomChart(),
    ListTasksScreen(),
    AboutUs(),
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
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ],
            ),
            child: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                textStyle:
                    TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 500),
                color: Theme.of(context).textTheme.bodyText2!.color,
                tabs: [
                  GButton(
                    iconActiveColor: Theme.of(context).scaffoldBackgroundColor,
                    icon: Icons.stacked_bar_chart_sharp,
                    backgroundColor: Theme.of(context).primaryColor,
                    text: 'Statistique',
                  ),
                  GButton(
                    iconActiveColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icons.list,
                    text: 'Liste des taches',
                  ),
                  GButton(
                    iconActiveColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icons.info,
                    text: 'A propos',
                  )
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ))));
  }
}


// BottomNavigationBar(
//         fixedColor: appBlue,
//         items: const [
//           BottomNavigationBarItem(
//               label: "Statistique", icon: Icon(Icons.stacked_bar_chart_sharp)),
//           BottomNavigationBarItem(
//               label: "Liste des taches", icon: Icon(Icons.list)),
//           BottomNavigationBarItem(label: "A propos", icon: Icon(Icons.info))
//         ],
//         currentIndex: selectedIndex,
//         onTap: (value) => setState(() {
//           selectedIndex = value;
//         }),
//       )