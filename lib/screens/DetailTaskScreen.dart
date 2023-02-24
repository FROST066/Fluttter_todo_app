import 'package:blog/data/models/task.dart';
import 'package:flutter/material.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key, required this.task});
  final Task task;
  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

enum level { Medium, Low, High }

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  level value = level.Low;
  bool isactiveR = false;
  bool isactiveY = false;
  bool isactiveG = true;

  bool isRed(level level_value) {
    if (level_value == level.High) {
      isactiveR = true;
      return true;
    } else {
      isactiveR = false;
      return false;
    }
  }

  bool isYellow(level level_value) {
    if (level_value == level.Medium) {
      isactiveY = true;
      return true;
    } else {
      isactiveY = false;
      return false;
    }
  }

  bool isGreen(level level_value) {
    if (level_value == level.Low) {
      isactiveG = true;
      return true;
    } else {
      isactiveG = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details of todo'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'TODO TITLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: isactiveR
                          ? [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ]
                          : null,
                      borderRadius: BorderRadius.circular(5),
                      color: isRed(value)
                          ? Colors.red
                          : Colors.grey.withOpacity(0.4),
                    ),
                    child: Text(
                      'HIGH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    height: 25,
                    width: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: isactiveY
                          ? [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ]
                          : null,
                      borderRadius: BorderRadius.circular(5),
                      color: isYellow(value)
                          ? Colors.orange
                          : Colors.grey.withOpacity(0.4),
                    ),
                    child: Text(
                      'MEDIUM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    height: 25,
                    width: 70,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: isactiveG
                          ? [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ]
                          : null,
                      borderRadius: BorderRadius.circular(5),
                      color: isGreen(value)
                          ? Colors.green
                          : Colors.grey.withOpacity(0.4),
                    ),
                    child: Text(
                      'LOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    height: 25,
                    width: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Description: ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          'lorem ipsum dolor la vie est belle',
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Date de création: ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          '22-08-205 à 18h:25',
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
