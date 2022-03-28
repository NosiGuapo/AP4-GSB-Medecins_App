import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/countryEditForm.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/regionAddForm.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/searchCountry.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/searchRegion.dart';
import 'package:ap4_gsbmedecins_appli/services/CountryService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants.dart';
import 'countryAddForm.dart';

enum _MenuValues { country, region }
enum _AddValues { addCountry, addRegion }

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
            PopupMenuButton<_AddValues>(
              icon: const Icon(Icons.add, color: Colors.grey),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text("Ajouter un pays"),
                  value: _AddValues.addCountry,
                ),
                const PopupMenuItem(
                  child: Text("Ajouter un département"),
                  value: _AddValues.addRegion,
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _AddValues.addRegion:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AddRegion();
                        },
                      ),
                    );
                    break;
                  case _AddValues.addCountry:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AddCountry();
                        },
                      ),
                    );
                    break;
                }
              },
            ),
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
                    return buildCountries(countries);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCountries(List<Country> countries) => Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("${countries.length} Résultats.")),
          Padding(
            padding: const EdgeInsets.only(top: 62),
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
                          onPressed: (edit) {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => EditCountry(country: country),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(country.nom),
                      onTap: null,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );

  Future listRefresh() async {
    setState(() => countries.clear());
  }
}




