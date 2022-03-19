import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/CountryService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants.dart';

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
            // IconButton(
            //     onPressed: () {
            //       showSearch(context: context, delegate: DoctorSearch());
            //     },
            //     icon: const Icon(Icons.search, color: Colors.grey)),
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
                                  CountryService.deleteCountry(country.id);
                                  delete.then((value) {
                                    final String snackMessage;
                                    if (value) {
                                      snackMessage = "Le pays suivant a été supprimé avec succès: ${country.nom}.";
                                      listRefresh();
                                    } else {
                                      snackMessage = "Une erreur est survenue lors de la suppression du pays.";
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
