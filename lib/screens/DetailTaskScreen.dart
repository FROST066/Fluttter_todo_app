import 'package:blog/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key, required this.task});
  final Task task;
  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Details de le tache')),
        body: Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40)
                    .copyWith(bottom: 10),
                child: Text(
                  widget.task.title,
                  style: GoogleFonts.lora(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Text(
                widget.task.description,
                style:
                    GoogleFonts.lora(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              const SizedBox(height: 20),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                // itemCount: filteredProductsList.length,
                children: [
                  Item(Icons.priority_high_rounded, "Priorite",
                      widget.task.priority, Colors.deepOrangeAccent),
                  Item(Icons.add, "Création", widget.task.createdAt, appBlue),
                  Item(Icons.close_sharp, "Deadline", widget.task.deadlineAt,
                      Colors.purple),
                  widget.task.beginedAt != null
                      ? Item(Icons.play_circle, "Démarrage",
                          widget.task.beginedAt!, Colors.green)
                      : const SizedBox(),
                  widget.task.finishedAt != null
                      ? Item(Icons.stop, "Arrêt", widget.task.finishedAt!,
                          Colors.red)
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget Item(IconData icon, String title, String date, Color color) {
  date = date.replaceAll(" ", " à ").replaceAll(":", " : ");
  date = date.replaceFirst(date[0], date[0].toUpperCase());

  return Container(
    height: 100,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 10,
              spreadRadius: 5)
        ]),
    child: Row(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            // margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            height: 300,
            width: 200,
            child: Icon(icon, color: Colors.white, size: 50),
          ),
        ),
        Flexible(
          flex: 5,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1.75, fontWeight: FontWeight.w400, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
