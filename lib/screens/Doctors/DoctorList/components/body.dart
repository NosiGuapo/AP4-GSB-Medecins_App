import 'package:ap4_gsbmedecins_appli/entities/User.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorList/components/background.dart';
import 'package:ap4_gsbmedecins_appli/services/UserService.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      bg: Scaffold(
        appBar: AppBar(
          title: const Text('Liste des utilisateurs'),
        ),
        body: FutureBuilder<List<User>>(
          future: UserService.getAllUsers(),
          builder: (context, snapshot) {

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final users = snapshot.data;
                  return buildUser(users!);
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildUser(List<User> users) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.fname + " " + user.lname),
          subtitle: Text(user.mail),
        );
      });
}


