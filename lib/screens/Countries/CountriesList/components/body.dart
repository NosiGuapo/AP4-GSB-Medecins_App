import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/body.dart';
import 'package:ap4_gsbmedecins_appli/services/CountryService.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:ap4_gsbmedecins_appli/services/RegionService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants.dart';
import '../../../../entities/Doctor.dart';

enum _MenuValues { country, region }

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Country> countries;

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
                  child: Text("Recherche par pays"),
                  value: _MenuValues.country,
                ),
                const PopupMenuItem(
                  child: Text("Recherche par département"),
                  value: _MenuValues.region,
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _MenuValues.country:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CountrySearch();
                        },
                      ),
                    );
                    break;
                  case _MenuValues.region:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegionSearch();
                        },
                      ),
                    );
                    break;
                }
              },
            ),
          ],
          title: const SizedBox(
            child: Text(
              "Liste des Pays",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: FutureBuilder<List<Country>>(
            future: CountryService.getCountries(),
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
                    countries = snapshot.data!;
                    return buildCountries(countries, countries.length);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCountries(List<Country> countries, int results) => Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("$results Résultats.")),
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: RefreshIndicator(
              onRefresh: listRefresh,
              color: primaryColour,
              strokeWidth: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 38),
                child: RefreshIndicator(
                  onRefresh: listRefresh,
                  color: primaryColour,
                  strokeWidth: 2,
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
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
                                      CountryService.deleteCountry(country.id!);
                                  delete.then((value) {
                                    final String snackMessage;
                                    if (value) {
                                      snackMessage =
                                          "Le pays suivant a été supprimé avec succès: ${country.nom}.";
                                      listRefresh();
                                    } else {
                                      snackMessage =
                                          "Une erreur est survenue lors de la suppression du pays.";
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
                              onPressed: null,
                              // onPressed: (edit) {
                              //   Navigator.of(context, rootNavigator: true).push(
                              //     MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           DoctorProfile(
                              //               doctorId: doctor.id!, isEdit: true),
                              //     ),
                              //   );
                              // },
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(country.nom),
                          onTap: null,
                          // onTap: () => Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         DoctorProfile(doctorId: doctor.id!),
                          //   ),
                          // ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Future listRefresh() async {
    setState(() => countries.clear());
  }
}

class CountrySearch extends StatefulWidget {
  const CountrySearch({Key? key}) : super(key: key);

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  late List<Country> countries;
  late List<Doctor> doctors;
  late int? fieldValue = countries.first.id;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black87),
          title: const SizedBox(
            child: Text(
              "Recherche par Pays",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Stack(
            children: [
              FutureBuilder<List<Country>>(
                future: CountryService.getCountries(),
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
                        countries = snapshot.data!;
                        return Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: DropdownButton<int>(
                                value: fieldValue,
                                items: [
                                  for (Country country in countries)
                                    DropdownMenuItem(
                                        value: country.id,
                                        child: Text(country.nom)),
                                ],
                                onChanged: (value) => setState(
                                  () => fieldValue = value,
                                ),
                              ),
                            ),
                            FutureBuilder<List<Doctor>>(
                              future: DoctorService.getDoctorsOfCountry(
                                  fieldValue!),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: primaryColour,
                                            strokeWidth: 2));
                                  default:
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      doctors = snapshot.data!;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 75),
                                        child: buildDoctors(doctors),
                                      );
                                    }
                                }
                              },
                            ),
                          ],
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDoctors(List<Doctor> doctors) => Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("${doctors.length} Résultats.")),
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

class RegionSearch extends StatefulWidget {
  const RegionSearch({Key? key}) : super(key: key);

  @override
  State<RegionSearch> createState() => _RegionSearchState();
}

class _RegionSearchState extends State<RegionSearch> {
  late List<Country> countries;
  late List<Departement> regions;
  late List<Doctor> doctors;
  late int? cFieldValue = countries.first.id;
  late int? rFieldValue = regions.first.id;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black87),
          title: const SizedBox(
            child: Text(
              "Recherche par Département",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Stack(
            children: [
              FutureBuilder<List<Country>>(
                future: CountryService.getCountries(),
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
                        countries = snapshot.data!;
                        return Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: DropdownButton<int>(
                                value: cFieldValue,
                                items: [
                                  for (Country country in countries)
                                    DropdownMenuItem(
                                        value: country.id,
                                        child: Text(country.nom)),
                                ],
                                onChanged: (value) => setState(() {
                                  cFieldValue = value;
                                  rFieldValue = regions.first.id;
                                }),
                              ),
                            ),
                            FutureBuilder<List<Departement>>(
                              future: RegionService.getRegionsOfCountry(cFieldValue!),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: primaryColour,
                                            strokeWidth: 2));
                                  default:
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      regions = snapshot.data!;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 55),
                                        child: Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.topCenter,
                                              child: DropdownButton<int>(
                                                value: rFieldValue,
                                                items: [
                                                  for (Departement region
                                                      in regions)
                                                    DropdownMenuItem(
                                                        value: region.id,
                                                        child: Text(region.nom)),
                                                ],
                                                onChanged: (value) => setState(
                                                  () => rFieldValue = value,
                                                ),
                                              ),
                                            ),
                                            FutureBuilder<List<Doctor>>(
                                              future: DoctorService
                                                  .getDoctorsOfRegion(
                                                      rFieldValue!),
                                              builder: (context, snapshot) {
                                                switch (
                                                    snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color:
                                                                    primaryColour,
                                                                strokeWidth: 2));
                                                  default:
                                                    if (!snapshot.hasData) {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    } else {
                                                      doctors = snapshot.data!;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 75),
                                                        child:
                                                            buildDoctors(doctors),
                                                      );
                                                    }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                }
                              },
                            ),
                          ],
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDoctors(List<Doctor> doctors) => Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("${doctors.length} Résultats.")),
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
