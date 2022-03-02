import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Médecins'),
          backgroundColor: primaryColour,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: FutureBuilder<List<Doctor>>(
            future: DoctorService.getAllDoctors(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final doctors = snapshot.data;
                    return buildDoctors(doctors!);
                  }
              }
            },
          ),
        )
      ),
    );
  }

  Widget buildDoctors(List<Doctor> doctors) => ListView.builder(
      // physics: const BouncingScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return ListTile(
          title: Text(doctor.prenom + " " + doctor.nom),
          subtitle: Text(doctor.adresse),
        );
      });
}


