import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/doctor_screen.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder<List<Doctor>>(
              future: DoctorService.getAllDoctors(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: primaryColour,
                      strokeWidth: 2,
                    ));
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
          )),
    );
  }

  Widget buildDoctors(List<Doctor> doctors) => ListView.builder(
      // physics: const BouncingScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Slidable(
          // Actions on the right part of each slide
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                backgroundColor: failToastColour,
                icon: Icons.delete,
                label: "Supprimer",
                onPressed: (BuildContext context) {
                  onDismissed(doctor.id, "d");
                },
                // flex: 1,
              ),
              SlidableAction(
                backgroundColor: Colors.blueAccent,
                icon: Icons.edit,
                label: "Modifier",
                onPressed: (BuildContext context) {
                  onDismissed(doctor.id, "e");
                },
              ),
            ],
          ),
          child: ListTile(
            title: Text(doctor.prenom + " " + doctor.nom),
            subtitle: Text(doctor.adresse),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DoctorScreen(doctor: doctor),
              ),
            ),
          ),
        );
      });

  void onDismissed(int id, String action) {
    switch (action) {
      case "d":
        final del = DoctorService.deleteDoctor(id);
        del.then((value) {
          // print(value);
          final String snackMessage;
          final Color bgColour;
          if (value) {
            snackMessage = "Le médecin a été supprimé avec succès.";
            bgColour = succeedToastColour;
          } else {
            snackMessage =
                "Une erreur est survenue lors de la suppression du médecin.";
            bgColour = failToastColour;
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              snackMessage,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 17,
                fontWeight: FontWeight.w400
              ),
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: bgColour,
            width: 350.0,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ));
        });
        break;
      case "e":
        print("edit");
        break;
      default:
        print("aaa");
        break;
    }
  }
}
