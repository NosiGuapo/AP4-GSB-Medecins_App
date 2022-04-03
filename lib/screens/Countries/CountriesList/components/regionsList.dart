import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/RegionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constants.dart';
import '../../../../entities/Country.dart';

class RegionList extends StatefulWidget {
  final Country country;
  const RegionList({required this.country, Key? key}) : super(key: key);

  @override
  State<RegionList> createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  late List<Departement> regions;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black45),
          title: SizedBox(
            child: Text(
              "Départements: ${widget.country.nom}",
              style: const TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 19),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: FutureBuilder<List<Departement>>(
            future: RegionService.getRegionsOfCountry(widget.country.id!),
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
                    regions = snapshot.data!;
                    return buildRegions(regions);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildRegions(List<Departement> regions) => Stack(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text("${regions.length} Résultats.")),
      Padding(
        padding: const EdgeInsets.only(top: 62),
        child: RefreshIndicator(
          onRefresh: listRefresh,
          color: primaryColour,
          strokeWidth: 2,
          child: ListView.builder(
            itemCount: regions.length,
            itemBuilder: (context, index) {
              final region = regions[index];
              return Stack(
                children: [
                  Slidable(
                    // Actions on the right part of each slide
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                            backgroundColor: failSnackbar,
                            icon: Icons.delete,
                            label: "Supprimer",
                            onPressed: (delete) {
                              final delete = RegionService.deleteRegion(region.id!);
                              delete.then((value) {
                                final String snackMessage;
                                if (value[0]) {
                                  snackMessage =
                                  "Le département suivant a été supprimé avec succès: ${region.nom}.";
                                  listRefresh();
                                } else {
                                  snackMessage = value[2];
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    buildSnackBar(value[0], snackMessage));
                              });
                            }
                          // flex: 1,
                        ),
                        SlidableAction(
                          backgroundColor: Colors.deepPurpleAccent.shade400,
                          icon: Icons.edit,
                          label: "Modifier",
                          onPressed: (edit) {
                            // Navigator.of(context, rootNavigator: true).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         EditCountry(country: country),
                            //   ),
                            // );
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(region.nom),
                      onTap: null
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ],
  );

  Future listRefresh() async {
    setState(() => regions.clear());
  }
}
