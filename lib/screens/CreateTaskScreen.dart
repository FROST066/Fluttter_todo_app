import 'dart:convert';

import 'package:blog/screens/home_page.dart';
import 'package:blog/widgets/customFlutterToast.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/models/task.dart';
import '../data/services/TaskService.dart';
import '../utils/styles.dart';
import '../widgets/CustomTextFormField.dart';

class CreateTaskScreen extends StatefulWidget {
  CreateTaskScreen({super.key});
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? priority = "high";
  String deadline_at = DateTime.now().toString().substring(0, 19);
  bool isLoading = false;
  createTask(formData) async {
    setState(() {
      isLoading = true;
    });
    try {
      Task? task = await TaskService.create(json.encode(formData));
      customFlutterToast(msg: "Tache créée avec succès");
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
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une tache"),
        centerTitle: true,
      ),
      // backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          // height: 300,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                        autofocus: true,
                        controller: titleController,
                        hintText: "Nom de la tâche",
                        prefixIcon: Icons.task),
                    CustomTextFormField(
                        autofocus: true,
                        controller: descriptionController,
                        hintText: "Description",
                        prefixIcon: Icons.description),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.transgender),
                          labelText: "Priorite",
                          contentPadding: EdgeInsets.only(right: 40),
                        ),
                        value: priority,
                        items: const [
                          DropdownMenuItem(value: "high", child: Text("High")),
                          DropdownMenuItem(
                              value: "medium", child: Text("Medium")),
                          DropdownMenuItem(value: "low", child: Text("Low"))
                        ],
                        onChanged: (value) {
                          setState(() {
                            priority = value;
                          });
                          // print(priority);
                        },
                        validator: (e) {
                          return (e == null)
                              ? "Ce champ est obligatoire"
                              : null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 3,
                              child: Text(
                                "   Deadline",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black.withOpacity(.5)),
                              )),
                          Expanded(
                            flex: 6,
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              initialValue:
                                  DateTime.now().toString().substring(0, 19),
                              dateMask: 'd-MM-yyyy',
                              firstDate: DateTime(2004, 1, 1),
                              lastDate: DateTime(2024, 1, 1),
                              calendarTitle: "Selectionnez une date ",
                              cancelText: "Annuler",
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onChanged: (val) {
                                setState(() {
                                  deadline_at = "$val:00";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.only(bottom: 10),
                // height: 100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  style: defaultStyle(context),
                  onPressed: () async {
                    if (!isLoading && _formKey.currentState!.validate()) {
                      final formData = {
                        "title": titleController.text,
                        "description": descriptionController.text,
                        "priority": priority,
                        "deadline_at": deadline_at
                      };
                      await createTask(formData);
                    }
                  },
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )
                      : const Text(
                          "Ajouter  ",
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
