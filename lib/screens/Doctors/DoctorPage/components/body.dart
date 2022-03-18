import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:ap4_gsbmedecins_appli/services/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 25),
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
              const SizedBox(height: 55),
              buildSubmit()
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

  Widget buildSubmit() => ElevatedButton(
    onPressed: () {
      // Will be in charge of validating the form fields
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        // The form is valid, we push to the next page or action
        formKey.currentState?.save();
        // Unfocus all input fields on validation
        FocusScope.of(context).unfocus();
      }
    },
    child: const Text("Modifier"),
  );
}
