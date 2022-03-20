import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/body.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants.dart';

enum _MenuValues {
  sectorOfActivity,
  completeName
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<_MenuValues>(
              icon: const Icon(Icons.search, color: Colors.grey),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text("Recherche par nom"),
                  value: _MenuValues.completeName,
                ),
                const PopupMenuItem(
                  child: Text("Recherche par spécialité"),
                  value: _MenuValues.sectorOfActivity,
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _MenuValues.completeName:
                    showSearch(context: context, delegate: DoctorSearch());
                    break;
                  case _MenuValues.sectorOfActivity:
                    null;
                    break;
                }
              },
            ),
          ],
          title: const SizedBox(
            child: Text(
              "Liste de médecins",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
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
                    return buildDoctors(doctors, doctors.length);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildDoctors(List<Doctor> doctors, int results) => Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("$results Résultats.")),
          Padding(
            padding: const EdgeInsets.only(top: 38),
            child: RefreshIndicator(
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
                            onPressed: (delete) {
                              final delete =
                                  DoctorService.deleteDoctor(doctor.id!);
                              delete.then((value) {
                                final String snackMessage;
                                if (value) {
                                  snackMessage =
                                      "Le médecin ${doctor.prenom} ${doctor.nom} a été supprimé avec succès.";
                                  // Refreshing the list on delete
                                  if (mounted) {
                                    listRefresh();
                                  } else {
                                    // Actions

                                  }
                                } else {
                                  snackMessage =
                                      "Une erreur est survenue lors de la suppression du médecin.";
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    buildSnackBar(value, snackMessage));
                              });
                            }
                            // flex: 1,
                            ),
                        SlidableAction(
                            backgroundColor: Colors.deepPurpleAccent.shade400,
                            icon: Icons.edit,
                            label: "Modifier",
                            onPressed: (edit) {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DoctorProfile(
                                          doctorId: doctor.id!, isEdit: true),
                                ),
                              );
                            }),
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
                              DoctorProfile(doctorId: doctor.id!),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );

  Future listRefresh() async {
    setState(() => doctors.clear());
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
    // If the query is empty, we return all the doctors
    final String? search;
    query.isEmpty ? search = null : search = query;
    return FutureBuilder<List<Doctor>>(
      future: DoctorService.getDoctors(search),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
                    color: primaryColour, strokeWidth: 2));
          default:
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.isEmpty) {
              return noSuggestionBuild();
            } else {
              var doctors = snapshot.data!.toList();
              return Padding(
                padding: const EdgeInsets.only(top: 18),
                child: listApp.buildDoctors(doctors, doctors.length),
              );
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
      'Aucun résultat.',
      style: TextStyle(fontFamily: 'Roboto', fontSize: 17),
    ));
  }

  Widget noQueryBuild() {
    return const Center(
        child: Text(
      'Veuillez entrer le nom d\'un médecin.',
      style: TextStyle(fontFamily: 'Roboto', fontSize: 17),
    ));
  }
}