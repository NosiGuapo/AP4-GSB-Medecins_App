import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
// import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Doctor doctor;

  const Body({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: Text("Page du médecin"),
          backgroundColor: primaryColour,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                radius: 70,
              ),
              const SizedBox(height: 40),
              Text(
                doctor.prenom + " " + doctor.nom,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 65),
              // ElevatedButton(
              //   onPressed: () {
              //     DoctorService.deleteDoctor(doctor.id);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: failToastColour,
              //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              //   ),
              //   child: const Text(
              //     "Supprimer",
              //     style: TextStyle(
              //       fontFamily: 'Roboto',
              //       fontSize: 17
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
