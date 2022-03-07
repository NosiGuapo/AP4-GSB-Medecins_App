import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
// import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
// import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Doctor doctor;

  const Body({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String spec;
    if (doctor.spec == null){
      spec = "Ce médecin ne possède aucune spécialité";
    } else {
      spec = doctor.spec!;
    }
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text(
              "Page du médecin",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              letterSpacing: -0.2
            ),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black45
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 55),
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
              const SizedBox(height: 35),
              ListTile(
                title: const Text("Adresse"),
                subtitle: Text(doctor.adresse),
                leading: const Icon(Icons.home),
              ),
              ListTile(
                title: const Text("Numéro de téléphone"),
                subtitle: Text(doctor.tel),
                leading: const Icon(Icons.phone),
              ),
              ListTile(
                title: const Text("Spécialité"),
                subtitle: Text(
                    spec
                ),
                leading: const Icon(Icons.medical_services),
              ),
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
