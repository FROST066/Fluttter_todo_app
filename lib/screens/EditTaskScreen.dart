import 'package:blog/data/models/task.dart';
import 'package:flutter/material.dart';
import '../data/services/TaskService.dart';
import '../widgets/CustomTextFormField.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({
    super.key,
    required this.task,
  });
  final Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool addOrEdit;
  @override
  void initState() {
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    // true == add
    // false == Edit
    // print(widget.task!.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Modifier une tache",
      )),
      // backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // color: Theme.of(widget.ctx).scaffoldBackgroundColor,
          ),
          height: 300,
          width: MediaQuery.of(context).size.width * 0.8,
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
                        controller: titleController,
                        hintText: "Description",
                        prefixIcon: Icons.description),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.only(bottom: 10),
                // height: 100,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  // style: defaultStyle(context),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final formData = {
                        "title": titleController.text,
                        "description": descriptionController.text,
                        "priority": "low",
                        "deadline_at": "2022-12-27 12:00:00"
                      };
                      TaskService.patch(
                          "34bc23f5-c22a-462b-a32e-1f3b517e6bf3", formData);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    addOrEdit ? "Creer" : "Modifier  ",
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
