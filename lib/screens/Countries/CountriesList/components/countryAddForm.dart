import 'package:ap4_gsbmedecins_appli/entities/Country.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/CountryService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/components/snackbar.dart';

class AddCountry extends StatefulWidget {
  const AddCountry({Key? key}) : super(key: key);

  @override
  State<AddCountry> createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  Country country = Country(nom: "");
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ajouter un pays",
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
                  initialValue: null,
                  validator: (value) {
                    if (value != null && value.length < 2) {
                      return "Le pays doit contenir au moins 2 caractères.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    country.nom = value;
                  }),
                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
                ),
                const SizedBox(height: 55),
                buildSubmit(country),
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
            final add = CountryService.createCountry(country);
            add.then((value) {
              final String snackMessage;
              if (value) {
                snackMessage = "Le pays suivant a été ajouté avec succès: ${country.nom}.";
              } else {
                snackMessage = "Une erreur est survenue lors de l'ajout du pays.";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(value, snackMessage));
              // Going back to the country page
              Navigator.of(context).pop();
            });
          }
        },
        child: const Text("Ajouter"),
      );
}
