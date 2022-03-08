import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
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

  late List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: SizedBox(
              height: 38,
              child: TextField(
                onChanged: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[250],
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none
                  ),
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: Colors.grey.shade500
                  ),
                  hintText: "Rechercher un médecin"
                ),
              ),
            ),
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
                      doctors = snapshot.data!;
                      return buildDoctors(doctors);
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
                backgroundColor: failSnackbar,
                icon: Icons.delete,
                label: "Supprimer",
                onPressed: (BuildContext context) {
                  onDismissed(doctor, "d", index);
                },
                // flex: 1,
              ),
              SlidableAction(
                backgroundColor: Colors.blueAccent,
                icon: Icons.edit,
                label: "Modifier",
                onPressed: (BuildContext context) {
                  onDismissed(doctor, "e", index);
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

  void onDismissed(Doctor doctor, String action, int index) {
    switch (action) {
      case "d":
        final delete = DoctorService.deleteDoctor(doctor.id);
        delete.then((value) {
          final String snackMessage;
          if (value) {
            snackMessage = "Le médecin ${doctor.prenom} ${doctor.nom} a été supprimé avec succès.";
            // Refreshing the list on delete
            setState(() => doctors.removeAt(index));
          } else {
            snackMessage = "Une erreur est survenue lors de la suppression du médecin.";
          }
          ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar(value, snackMessage)
          );
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
