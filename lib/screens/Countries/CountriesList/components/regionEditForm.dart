import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:ap4_gsbmedecins_appli/services/CountryService.dart';
import 'package:ap4_gsbmedecins_appli/services/RegionService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';

import '../../../../components/snackbar.dart';
import '../../../../constants.dart';

class EditRegion extends StatefulWidget {
  final Departement region;
  const EditRegion({required this.region, Key? key}) : super(key: key);

  @override
  State<EditRegion> createState() => _EditRegionState();
}

class _EditRegionState extends State<EditRegion> {
  late List<Country> countries;
  late int? fieldValue;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Modifier un département",
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
          body: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  const SizedBox(height: 25),
                  buildFormInput(
                    name: "Nom du département",
                    icon: Icons.room,
                    initialValue: widget.region.nom,
                    hint: "Yvelines",
                    saves: (value) {
                      setState(() => widget.region.nom = value);
                      return null;
                    },
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return "Le nom du département doit contenir au moins deux caractères.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              countries = snapshot.data!;
                              for (var country in countries) {
                                if (country.id == widget.region.pays!.id){
                                  fieldValue = country.id;
                                }
                              }
                              return DropdownButtonFormField<int?>(
                                value: fieldValue,
                                items: [
                                  for (Country country in countries)
                                    DropdownMenuItem(
                                        value: country.id,
                                        child: Text(country.nom)),
                                ],
                                onChanged: (value) => setState(() {
                                  fieldValue = value;
                                  print(fieldValue);
                                  widget.region.pays?.id = fieldValue;
                                }),
                                onSaved: (value) => setState(() {
                                  fieldValue = value;
                                  widget.region.pays?.id = fieldValue;
                                }),
                              );
                            }
                        }
                      }),
                  const SizedBox(height: 55),
                  buildSubmit(widget.region),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildSubmit(Departement region) => ElevatedButton(
    onPressed: () {
      final isValid = formKey.currentState?.validate();
      if (isValid!) {
        formKey.currentState?.save();
        // print(region.toJson());
        final add = RegionService.editRegion(region);
        add.then((value) {
          final String snackMessage;
          if (value[0]) {
            snackMessage = "Le département suivant a été modifié avec succès: ${region.nom}.";
            Navigator.of(context).pop();
          } else {
            snackMessage = value[2];
          }
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(value[0], snackMessage));
        });
      }
    },
    child: const Text("Ajouter"),
  );

  Widget buildFormInput({
    required String name,
    required IconData icon,
    String? initialValue,
    String? hint,
    required String? Function(dynamic value) validator,
    required String? Function(dynamic value) saves,
    int? max,
  }) =>
      TextFormField(
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(fontFamily: 'Roboto', fontSize: 15),
          prefixIcon: Icon(icon),
          border: null,
          hintText: hint,
        ),
        maxLength: max,
        initialValue: initialValue,
        validator: validator,
        onChanged: saves,
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
      );
}
