import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:ap4_gsbmedecins_appli/services/RegionService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/components/background.dart';

import '../../../../components/snackbar.dart';
import '../../../../constants.dart';
import '../../../../entities/Doctor.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final formKey = GlobalKey<FormState>();
  Doctor doctor = Doctor(
      nom: "",
      prenom: "",
      adresse: "",
      tel: "",
      spec: null,
      departement: Departement(id: null, nom: ""));
  late List<Departement> regions;
  late int? fieldValue = regions.first.id;

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Ajouter un Médecin",
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
                padding: const EdgeInsets.all(5),
                children: <Widget>[
                  const SizedBox(height: 25),
                  buildFormInput(
                    name: "Nom",
                    icon: Icons.person,
                    initialValue: doctor.nom,
                    hint: "Durand",
                    saves: (value) {
                      setState(() => doctor.nom = value);
                    },
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return "Le nom doit contenir au moins 2 caractères.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  buildFormInput(
                    name: "Prénom",
                    icon: Icons.person,
                    initialValue: doctor.prenom,
                    hint: "Samuel",
                    saves: (value) {
                      setState(() => doctor.prenom = value);
                    },
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return "Le prénom doit contenir au moins 2 caractères.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  buildFormInput(
                    name: "Adresse",
                    icon: Icons.home,
                    initialValue: doctor.adresse,
                    hint: "41 rue de Valmy MONTREUIL 93100",
                    saves: (value) {
                      setState(() => doctor.adresse = value);
                    },
                    validator: (value) {
                      if (value != null && value.length < 10) {
                        return "L'adresse doit contenir au moins une dizaine de caractères.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  buildFormInput(
                    name: "Téléphone",
                    icon: Icons.phone,
                    initialValue: doctor.tel,
                    hint: "0637645529",
                    saves: (value) {
                      setState(() => doctor.tel = value);
                    },
                    max: 15,
                    validator: (value) {
                      if (value != null && value.length < 10) {
                        return "Le numéro de téléphone doit contenir plus de 9 caractères.";
                      } else {
                        // Regex:
                        // | Phone number needs to start with a 0
                        // | Phone number needs to be between 10 and 15 characters long
                        // | Phone needs to contain digits only
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  buildFormInput(
                    name: "Spécialité",
                    icon: Icons.medical_services,
                    initialValue: doctor.spec,
                    hint: "Oncologie",
                    saves: (value) {
                      setState(() => doctor.spec = value);
                      return null;
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Département",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 15, color: Colors.black45),
                  ),
                  FutureBuilder<List<Departement>>(
                    future: RegionService.getRegions(),
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
                            regions = snapshot.data!;
                            return DropdownButtonFormField<int>(
                              value: fieldValue,
                              items: [
                                for (Departement region in regions)
                                  DropdownMenuItem(
                                      value: region.id,
                                      child: Text(region.nom)),
                              ],
                              onChanged: (value) => setState(() {
                                fieldValue = value;
                                doctor.departement?.id = fieldValue;
                              }),
                              onSaved: (value) => setState(() {
                                fieldValue = value;
                                doctor.departement?.id = fieldValue;
                              }),
                            );
                          }
                      }
                    },
                  ),
                  const SizedBox(height: 55),
                  buildSubmit(doctor),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildSubmit(Doctor doctor) => ElevatedButton(
        onPressed: () {
          final isValid = formKey.currentState?.validate();
          if (isValid!) {
            formKey.currentState?.save();
            final add = DoctorService.createDoctor(doctor);
            add.then((value) {
              final String snackMessage;
              if (value) {
                snackMessage =
                    "Le docteur suivant a été ajouté avec succès: ${doctor.nom} ${doctor.prenom}.";
                Navigator.of(context).pop();
              } else {
                snackMessage =
                    "Une erreur est survenue lors de l'ajout du docteur.";
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(buildSnackBar(value, snackMessage));
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
        onSaved: saves,
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
      );
}
