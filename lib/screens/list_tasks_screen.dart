import 'package:blog/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/task.dart';
import '../data/services/TaskService.dart';
import 'CreateTaskScreen.dart';
import 'DetailTaskScreen.dart';

class ListTasksScreen extends StatefulWidget {
  const ListTasksScreen({super.key});

  @override
  State<ListTasksScreen> createState() => _ListTasksScreenState();
}

class _ListTasksScreenState extends State<ListTasksScreen> {
  List<Task> tasks = [];
  bool isLoadingTasks = false;

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
            msg: "Une erreur est survenue veuillez rééssayer");
        print("pb de connection");
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
        title: const Text("Liste des tasks"),
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
      body: isLoadingTasks
          ? const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.list_alt),
                        title: Text(
                          tasks[index].title,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                            "Description: ${tasks[index].description.length > 50 ? tasks[index].description.substring(0, 50) : tasks[index].description}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailTaskScreen(task: tasks[index])));
                        },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateTaskScreen())),
        tooltip: 'Creer une tache',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
