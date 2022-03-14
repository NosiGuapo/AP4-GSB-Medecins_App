import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
import '../../../../constants.dart';

class DetailBody extends StatelessWidget {
  final Doctor doctor;

  const DetailBody({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String spec;
    if (doctor.spec == null) {
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
                letterSpacing: -0.2),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black45),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 45),
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                radius: 70,
                backgroundColor: primaryColour,
              ),
              const SizedBox(height: 35),
              Text(
                doctor.prenom + " " + doctor.nom,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 60),
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
                subtitle: Text(spec),
                leading: const Icon(Icons.medical_services),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditBody extends StatelessWidget {
  final Doctor doctor;

  const EditBody({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: Text(
            "Modifier le médecin: ${doctor.prenom} ${doctor.nom}",
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                letterSpacing: -0.2),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black45),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nom",
                      prefixIcon: Icon(Icons.person),
                      border: null,
                      hintText: "Durand"),
                  validator: (value) {
                    if (value != null && value.length < 2) {
                      return "Le nom doit contenir au moins 2 caractères.";
                    } else {
                      // Input data is valid, no error message returned
                      return null;
                    }
                  },
                ),
                const ElevatedButton(onPressed: null, child: Text("Modifier")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
