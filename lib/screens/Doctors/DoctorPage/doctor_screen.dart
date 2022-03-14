import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class DoctorScreen extends StatelessWidget {
  final Doctor doctor;
  final bool editPage;

  const DoctorScreen({
    Key? key,
    required this.doctor,
    this.editPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editPage){
      return Scaffold(
        body: EditBody(doctor: doctor),
      );
    } else {
      return Scaffold(
        body: DetailBody(doctor: doctor),
      );
    }
  }
}
