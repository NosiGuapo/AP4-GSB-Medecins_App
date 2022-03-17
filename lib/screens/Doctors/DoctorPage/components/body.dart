import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
import '../../../../constants.dart';

class DetailBody extends StatelessWidget {
  final Doctor doctor;

  const DetailBody({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String spec;
    if (doctor.spec == null) {
      spec = "Ce médecin ne possède aucune spécialité";
    } else {
      spec = doctor.spec!;
    }
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
        body: Center(
          child: Column(
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
                subtitle: Text("${doctor.adresse}\n${doctor.departement!.nom}, ${doctor.departement!.pays!.nom}"),
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
                subtitle: Text(spec),
                leading: const Icon(Icons.medical_services),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditBody extends StatefulWidget {
  Doctor doctor;

  EditBody({required this.doctor, Key? key}) : super(key: key);

  @override
  State<EditBody> createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBody> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: Text(
            "Modifier le médecin: ${widget.doctor.prenom} ${widget.doctor.nom}",
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                letterSpacing: -0.2),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black45),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                buildFormInput(
                  name: "Nom",
                  icon: Icons.person,
                  initialValue: widget.doctor.nom,
                  hint: "Durand",
                  saves: (value) {
                    setState(() => widget.doctor.nom = value);
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
                  initialValue: widget.doctor.prenom,
                  hint: "Samuel",
                  saves: (value) {
                    setState(() => widget.doctor.prenom = value);
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
                  initialValue: widget.doctor.adresse,
                  hint: "41 rue de Valmy MONTREUIL 93100",
                  saves: (value) {
                    setState(() => widget.doctor.adresse = value);
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
                  initialValue: widget.doctor.tel,
                  hint: "0637645529",
                  saves: (value) {
                    setState(() => widget.doctor.tel = value);
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
                  initialValue: widget.doctor.spec,
                  hint: "Oncologie",
                  saves: (value) {
                    setState(() => widget.doctor.spec = value);
                  },
                  validator: (value) {},
                ),
                const SizedBox(height: 25),
                // DropdownButton(
                //   items: items,
                //   onChanged: onChanged,
                //   value: widget.doctor,
                // ),
                const SizedBox(height: 55),
                buildSubmit()
              ],
            ),
          ),
        ),
      ),
    );
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
