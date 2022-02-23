import 'package:ap4_gsbmedecins_appli/screens/SignIn/signin_screen.dart';
import 'package:ap4_gsbmedecins_appli/screens/Welcome/components/body.dart';
import 'package:ap4_gsbmedecins_appli/themes.dart';
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
      // Header
      appBar: AppBar(
        title: const Text("Feur"),
        backgroundColor: primaryColour,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              actualTheme.toggleTheme();
            },
          )
        ],
      ),
      // Body (managed and filled with other parts of the flutter app)
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
          SignInScreen()
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        // Defining index currently used
        currentIndex: _currentIndex,
        // Define which index is currently in use (defined by ordering number from 0 to x)
        onTap: (index) {
          // Passing the correct index
          setState(() {
            index = _currentIndex;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        items: const <BottomNavigationBarItem>[
          // A Navbar required more than a single item in order to work
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil",
              backgroundColor: primaryColour
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Example",
              backgroundColor: primaryColour
          ),
        ],
      ),
    );
  }
}
