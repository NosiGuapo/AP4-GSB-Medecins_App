import 'package:ap4_gsbmedecins_appli/entities/Departement.dart';
import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:ap4_gsbmedecins_appli/services/RegionService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
import '../../../../components/snackbar.dart';
import '../../../../constants.dart';

class DoctorProfile extends StatefulWidget {
  final int doctorId;
  final bool isEdit;

  const DoctorProfile({required this.doctorId, this.isEdit = false, Key? key})
      : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late Doctor doctor;
  late int? fieldValue;
  int? ogFieldValue;
  late List<Departement> regions;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit){
      return Background(
        bg: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Modifier le médecin",
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
              padding: const EdgeInsets.only(top: 3), child: buildDoctor()),
        ),
      );
    } else {
      return Background(
        bg: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Page du médecin",
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
              padding: const EdgeInsets.only(top: 3), child: buildDoctor()),
        ),
      );
    }
  }


  Widget buildDoctor() => FutureBuilder<Doctor?>(
        future: DoctorService.getDoctorById(widget.doctorId),
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
                doctor = snapshot.data!;
                return RefreshIndicator(
                    onRefresh: listRefresh,
                    color: primaryColour,
                    strokeWidth: 2,
                    child:
                        widget.isEdit ? buildEditPage() : buildProfilePage());
              }
          }
        },
      );


  // Part builds
  Widget buildProfilePage() => Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 45),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
            radius: 70,
            backgroundColor: primaryColour,
          ),
          const SizedBox(height: 35),
          Text(
            doctor.prenom + " " + doctor.nom,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 60),
          ListTile(
            title: const Text("Localisation"),
            subtitle: Text(
                "${doctor.adresse}\n${doctor.departement!.nom}, ${doctor.departement!.pays!.nom}"),
            leading: const Icon(Icons.home),
            isThreeLine: true,
          ),
          ListTile(
            title: const Text("Numéro de téléphone"),
            subtitle: Text(doctor.tel),
            leading: const Icon(Icons.phone),
          ),
          ListTile(
            title: const Text("Spécialité"),
            subtitle: doctor.spec != null? Text(doctor.spec!) : const Text("Ce médecin ne possède aucune spécialité."),
            leading: const Icon(Icons.medical_services),
          ),
        ],
      );


  Widget buildEditPage() => Center(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
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
                  var pattern = RegExp("^[0-9]{9,14}\$");
                  if (value == null) {
                    return "Veuillez préciser un numéro de téléphone";
                  } else if (!pattern.hasMatch(value)) {
                    return "Le numéro de téléphone doit contenir entre 9 et 14 chiffres.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 5),
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
                          if (ogFieldValue == null){
                            for (var region in regions) {
                              if (region.id == doctor.departement!.id){
                                ogFieldValue = region.id;
                                fieldValue = ogFieldValue;
                              }
                            }
                          }
                          return DropdownButtonFormField<int?>(
                            value: fieldValue,
                            items: [
                              for (Departement region in regions)
                                DropdownMenuItem(
                                    value: region.id,
                                    child: Text(region.nom)),
                            ],
                            onChanged: (value) => setState(() {
                              fieldValue = value;
                              print(fieldValue);
                              doctor.departement?.id = fieldValue;
                            }),
                            onSaved: (value) => setState(() {
                              fieldValue = value;
                              doctor.departement?.id = fieldValue;
                            }),
                          );
                        }
                    }
                  }),
              const SizedBox(height: 55),
              buildSubmit(doctor)
            ],
          ),
        ),
      );

  Future listRefresh() async {
    return null;
  }

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
        onSaved: saves,
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
      );

  Widget buildSubmit(Doctor doctor) => ElevatedButton(
    onPressed: () {
      final isValid = formKey.currentState?.validate();
      if (isValid!) {
        formKey.currentState?.save();
        // print(region.toJson());
        final add = DoctorService.editDoctor(doctor);
        add.then((value) {
          final String snackMessage;
          if (value[0]) {
            snackMessage = "Le médecin suivant a été modifié avec succès: \n${doctor.prenom} ${doctor.nom}.";
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
}
