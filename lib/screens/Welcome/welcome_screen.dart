import 'package:ap4_gsbmedecins_appli/screens/Countries/CountriesList/countries_screen.dart';
import 'package:ap4_gsbmedecins_appli/screens/Profile/profile_screen.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/body.dart';
import 'package:ap4_gsbmedecins_appli/screens/Doctors/DoctorList/doctors_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

// stless to trigger the class
// stful to trigger the other kind
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  // Avoiding state-related errors
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          // Setting up multiple body makes the user able to swipe from a body to another, however the global structure will be kept (Header etc)
          // The current setup is momentary and will be improved when the complete auth system is up
          Body(),
          DoctorsScreen(),
          CountriesScreen(),
          ProfileScreen(),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _pageController.jumpToPage(index),
        items: const <BottomNavigationBarItem>[
          // A Navbar required more than a single item in order to work
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: "Médecins",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room),
            label: "Pays/Départements",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
        // Icons colour while active
        fixedColor: primaryColour,
        // Icons colour while inactive
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
      ),
    );
  }
}
