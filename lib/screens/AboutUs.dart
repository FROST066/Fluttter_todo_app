import 'package:blog/utils/constants.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('A propos')),
        body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.info, size: 100, color: appBlue),
                  ),
                  const Text(
                    "Vous en avez assez d'oublier les tâches importantes de votre journée ? Avec notre application de gestion de tâches, vous pouvez organiser votre emploi du temps et ne plus rien laisser passer. Gagnez du temps et de la productivité !!! Ne remettez plus à demain ce que vous pouvez faire aujourd'hui grâce à notre application de gestion de tâches.",
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10)
                            .copyWith(top: 25),
                        child: const Text(
                          "Les membres de la team :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "HOUEHA Karen\nGUIDIMADJEGBE Pacitte\nGNANIH Jordy\nHOUNDJO S. Prince\nAMOUSSOU Adna\nHOUNKPE Axel\nPATINVOH Elvis\nELECHO Serge",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
