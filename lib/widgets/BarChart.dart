import 'package:blog/utils/constants.dart';
import 'package:flutter/material.dart';

// const Map<String, Color> colorsMap = {
//   "Toutes les tâches": Colors.green,
//   "Tâches non commencées": Colors.cyanAccent,
//   "Tâches en cours": Colors.orange,
//   "Tâches finies": Colors.purple,
//   "Tâches finies avec retard": Colors.red
// };

const Map<String, Color> colorsMap = {
  "Toutes les tâches": appBlue,
  "Tâches non commencées": appBlue,
  "Tâches en cours": appBlue,
  "Tâches finies": appBlue,
  "Tâches finies avec retard": appBlue
};

class CustomChart extends StatelessWidget {
  CustomChart({super.key, required this.dataMap});
  final Map<String, int> dataMap;
  double totalWidth = 0;
  @override
  Widget build(BuildContext context) {
    totalWidth = MediaQuery.of(context).size.width * .8;
    return Scaffold(
      appBar: AppBar(title: const Text("Statistiques")),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dataMap.entries
                .toList()
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.key,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CustomAnimatedContainer(
                                width: totalWidth *
                                    e.value.toDouble() /
                                    dataMap["Toutes les tâches"]!,
                                color: colorsMap[e.key]!),
                            Text(
                              e.value.toString(),
                              style: TextStyle(color: colorsMap[e.key]!),
                            )
                          ],
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedContainer extends StatefulWidget {
  const CustomAnimatedContainer(
      {super.key, required this.width, required this.color});
  final double width;
  final Color color;
  @override
  State<CustomAnimatedContainer> createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  double width = 0;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5), () {
      setState(() {
        width = widget.width;
      });
    });
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 6),
      curve: Curves.fastOutSlowIn,
      width: width,
      duration: const Duration(milliseconds: 1300),
      decoration: BoxDecoration(
        border: Border.all(color: widget.color, width: 7.0),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      height: 50,
      child: Container(color: widget.color),
    );
  }
}
