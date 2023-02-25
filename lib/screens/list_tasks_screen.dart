import 'dart:convert';

import 'package:blog/screens/login_screen.dart';
import 'package:blog/screens/sqlite_list_tasks.dart';
import 'package:blog/utils/constants.dart';
import 'package:blog/utils/styles.dart';
import 'package:blog/widgets/CustomLoader.dart';
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

class ListTasksScreen extends StatefulWidget {
  const ListTasksScreen({super.key});

  @override
  State<ListTasksScreen> createState() => _ListTasksScreenState();
}

class _ListTasksScreenState extends State<ListTasksScreen> {
  List<Task> tasks = [];
  bool isLoadingTasks = false, isUpdating = false, showOnNetworkFailed = false;

  updateTask(id, formData) async {
    setState(() {
      isUpdating = true;
    });
    try {
      Task? task = await TaskService.patch(id, json.encode(formData));
      // customFlutterToast(msg: "Tache modifiée avec succès");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage(selectedIndex: 1)),
          (route) => false);
      print("Created Task---------$task");
    } on DioError catch (e) {
      print(e);
      Map<String, dynamic>? error = e.response?.data;
      if (error != null && error.containsKey('message')) {
        customFlutterToast(msg: error['message']);
      } else {
        customFlutterToast(msg: "Une erreur est survenue veuillez rééssayer");
      }
    } finally {
      isUpdating = false;
      setState(() {});
    }
  }

  loadTasks() async {
    setState(() {
      isLoadingTasks = true;
    });
    try {
      tasks = await TaskService.fetch();
      print("All task got--------------$tasks");
    } on DioError catch (e) {
      print(e);
      Map<String, dynamic>? error = e.response?.data;
      if (error != null && error.containsKey('message')) {
        Fluttertoast.showToast(msg: error['message']);
      } else {
        Fluttertoast.showToast(
            msg: "Une erreur est survenue. Verifier votre connexion ");
        setState(() {
          showOnNetworkFailed = true;
        });
      }
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
        title: const Text("Liste des tâches"),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: showOnNetworkFailed
          ? Center(
              child: ElevatedButton(
                  style: defaultStyle(context),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SQFListTasksScreen())),
                  child: const Text("Afficher la liste hors ligne")),
            )
          : isLoadingTasks
              ? customLoader()
              : tasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailTaskScreen(task: tasks[index]))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: tasks[index].beginedAt == null
                                    ? Colors.blueGrey[100]
                                    : tasks[index].finishedAt == null
                                        ? Colors.green[100]
                                        : Colors.grey[400],
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.only(
                                bottom: 8, right: 8, top: 8),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                const Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, right: 15),
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
                                            tasks[index].title,
                                            maxLines: 1,
                                            style: GoogleFonts.lora(
                                                color: appBlue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: tasks[index]
                                                              .finishedAt ==
                                                          null
                                                      ? () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditTaskScreen(
                                                                      task: tasks[
                                                                          index])))
                                                      : null,
                                                  icon: Icon(Icons.edit,
                                                      color: tasks[index]
                                                                  .finishedAt ==
                                                              null
                                                          ? appBlue
                                                          : Colors.grey)),
                                              Visibility(
                                                  visible:
                                                      tasks[index].finishedAt ==
                                                          null,
                                                  child: tasks[index]
                                                              .beginedAt ==
                                                          null
                                                      ? ElevatedButton(
                                                          style: defaultStyle(
                                                              context),
                                                          onPressed: () async {
                                                            if (!isUpdating) {
                                                              final formData = {
                                                                "begined_at": DateTime
                                                                        .now()
                                                                    .toString()
                                                                    .substring(
                                                                        0, 19)
                                                              };
                                                              print(
                                                                  "formData--------$formData");
                                                              await updateTask(
                                                                  tasks[index]
                                                                      .id,
                                                                  formData);
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Commencer"))
                                                      : ElevatedButton(
                                                          style: defaultStyle(
                                                                  context)
                                                              .copyWith(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .red)),
                                                          onPressed: () async {
                                                            if (!isUpdating) {
                                                              final formData = {
                                                                "finished_at": DateTime
                                                                        .now()
                                                                    .toString()
                                                                    .substring(
                                                                        0, 19)
                                                              };
                                                              print(
                                                                  "formData--------$formData");
                                                              await updateTask(
                                                                  tasks[index]
                                                                      .id,
                                                                  formData);
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Arrêter"),
                                                        ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(tasks[index].description.length > 50
                                        ? "${tasks[index].description.substring(0, 50)}..."
                                        : tasks[index].description)
                                  ],
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Aucunes taches",
                        style: TextStyle(
                            fontSize: 20.0, fontStyle: FontStyle.italic),
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateTaskScreen())),
        tooltip: 'Creer une tache',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
