import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorPage/components/background.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  final Doctor doctor;
  const Body({
    required this.doctor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: Text(doctor.prenom+" "+doctor.nom),
          backgroundColor: primaryColour,
        ),
      ),
    );
  }
}
