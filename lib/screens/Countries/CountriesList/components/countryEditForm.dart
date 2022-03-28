import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';
import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';

import '../../../../services/CountryService.dart';

class EditCountry extends StatefulWidget {
  final Country country;

  const EditCountry({required this.country, Key? key}) : super(key: key);

  @override
  State<EditCountry> createState() => _EditCountryState();
}

class _EditCountryState extends State<EditCountry> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Modifier un pays",
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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nom du pays",
                    labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                    prefixIcon: Icon(Icons.room),
                    border: null,
                    hintText: "Italie",
                  ),
                  initialValue: widget.country.nom,
                  validator: (value) {
                    if (value != null && value.length < 2) {
                      return "Le pays doit contenir au moins 2 caractères.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    widget.country.nom = value;
                  }),
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
                ),
                const SizedBox(height: 55),
                buildSubmit(widget.country),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmit(Country country) => ElevatedButton(
        onPressed: () {
          final isValid = formKey.currentState!.validate();
          if (isValid) {
            formKey.currentState?.save();
            final add = CountryService.editCountry(country);
            add.then((value) {
              final String snackMessage;
              if (value[0]) {
                snackMessage = "Le pays ${country.nom} a été modifié avec succès.";
                // Going back to the country page
                Navigator.of(context).pop();
              } else if (value[1] == 401) {
                snackMessage = "Un pays avec ce nom existe déja.";
              } else {
                snackMessage = value[2];
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(buildSnackBar(value[0], snackMessage));
            });
          }
        },
        child: const Text("Modifier"),
      );
}
