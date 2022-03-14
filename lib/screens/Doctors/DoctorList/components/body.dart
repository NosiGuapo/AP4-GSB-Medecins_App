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
  late List<Doctor> doctors;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: DoctorSearch());
                  },
                  icon: const Icon(Icons.search, color: Colors.grey)),
            ],
            title: const SizedBox(
              child: Text(
                "Liste de médecins",
                style: TextStyle(
                    fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
              ),
              // height: 38,
              // child: TextField(
              //   onChanged: (value) => onSearch(value),
              //   decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.grey[250],
              //       contentPadding: const EdgeInsets.all(0),
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.grey.shade500,
              //       ),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(50),
              //           borderSide: BorderSide.none),
              //       hintStyle: TextStyle(
              //           fontSize: 16,
              //           fontFamily: 'Roboto',
              //           color: Colors.grey.shade500),
              //       hintText: "Rechercher un médecin"),
              // ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder<List<Doctor>>(
              future: DoctorService.getDoctors(null),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                        child: CircularProgressIndicator(
                            color: primaryColour, strokeWidth: 2));
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

  Widget buildDoctors(List<Doctor> doctors) => RefreshIndicator(
        onRefresh: listRefresh,
        color: primaryColour,
        strokeWidth: 2,
        child: ListView.builder(
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
                      backgroundColor: Colors.deepPurpleAccent.shade400,
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
                  leading: CircleAvatar(
                    child: ClipOval(
                        child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white54, BlendMode.lighten),
                      child: Image.asset("assets/images/profile.png"),
                    )),
                    backgroundColor: primaryColour,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DoctorScreen(doctor: doctor),
                    ),
                  ),
                ),
              );
            }),
      );

  Future listRefresh() async {
    setState(() => doctors.clear());
  }

  void onDismissed(Doctor doctor, String action, int index) {
    switch (action) {
      case "d":
        final delete = DoctorService.deleteDoctor(doctor.id);
        delete.then((value) {
          final String snackMessage;
          if (value) {
            snackMessage =
                "Le médecin ${doctor.prenom} ${doctor.nom} a été supprimé avec succès.";
            // Refreshing the list on delete
            // setState(() => doctors.removeAt(index));
            setState(() => doctors.clear());
          } else {
            snackMessage =
                "Une erreur est survenue lors de la suppression du médecin.";
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(buildSnackBar(value, snackMessage));
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

class DoctorSearch extends SearchDelegate<String> {
  final listApp = _BodyState();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Cross icon - Clears field query
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Arrow icon - Go back to the previous page (doctor list)
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Doctor>>(
      future: DoctorService.getDoctors(query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
                    color: primaryColour, strokeWidth: 2));
          default:
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return listApp.buildDoctors(snapshot.data!.toList());
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // We want the same display, we can directly use the result FutureBuilder instead of making an useless one
    return buildResults(context);
  }

  // No result matching - We alert the user with a small message
  Widget noSuggestionBuild() {
    return const Center(
        child: Text(
      'Aucun résultat',
      style: TextStyle(fontFamily: 'Roboto', fontSize: 17),
    ));
  }
}
