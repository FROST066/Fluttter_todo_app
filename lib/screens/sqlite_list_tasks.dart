import 'dart:convert';

import 'package:blog/data/services/db_provider.dart';
import 'package:blog/screens/login_screen.dart';
import 'package:blog/utils/constants.dart';
import 'package:blog/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/task.dart';
import '../data/services/TaskService.dart';
import '../widgets/customFlutterToast.dart';
import 'CreateTaskScreen.dart';
import 'DetailTaskScreen.dart';
import 'EditTaskScreen.dart';
import 'home_page.dart';

class SQFListTasksScreen extends StatefulWidget {
  const SQFListTasksScreen({super.key});

  @override
  State<SQFListTasksScreen> createState() => _SQFListTasksScreenState();
}

class _SQFListTasksScreenState extends State<SQFListTasksScreen> {
  bool isLoadingTasks = false, isUpdating = false;
  List<Map<String, dynamic>> taskMap = [];

  loadTasks() async {
    setState(() {
      isLoadingTasks = true;
    });
    try {
      TodoProvider db = TodoProvider();
      taskMap = await db.getAll();
      print("All task got--------------$taskMap");
    } catch (e) {
      print("Error while getting tasks $e");
    } finally {
      isLoadingTasks = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des tâches hors ligne"),
      ),
      body: isLoadingTasks
          ? const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : taskMap.isNotEmpty
              ? ListView.builder(
                  itemCount: taskMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8)),
                      padding:
                          const EdgeInsets.only(bottom: 8, right: 8, top: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 8, right: 15),
                              child: Icon(Icons.list_alt)),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      taskMap[index]['title'],
                                      maxLines: 1,
                                      style: GoogleFonts.lora(
                                          color: appBlue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(taskMap[index]["description"].length > 50
                                  ? "${taskMap[index]["description"].substring(0, 50)}..."
                                  : taskMap[index]["description"])
                            ],
                          )),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "Aucunes taches",
                    style:
                        TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  ),
                ),
    );
  }
}
