import 'package:ap4_gsbmedecins_appli/entities/Doctor.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class DoctorScreen extends StatelessWidget {
  final Doctor doctor;
  const DoctorScreen({
    Key? key,
    required this.doctor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(doctor: doctor),
    );
  }
}
