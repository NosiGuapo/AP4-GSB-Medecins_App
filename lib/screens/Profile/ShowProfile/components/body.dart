import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import '../../../../components/icon_options.dart';
import 'background.dart';
import 'package:ap4_gsbmedecins_appli/themes.dart';


class Body extends StatefulWidget {
  static const keyDarkMode = 'key-dark-mode';
  static const keyLanguage = 'key-app-language';

  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      bg: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            SettingsGroup(
              title: 'Général',
              children: <Widget>[
                darkModeOption(),
                languageOption()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget languageOption() => DropDownSettingsTile(
        settingKey: Body.keyLanguage,
        title: 'Langue',
        // Language by default
        selected: 1,
        // Option list
        values: const <int, String>{1: 'Français', 2: 'English', 3: 'Deutsch'},
        onChange: (language) {},
      );

  Widget darkModeOption() => SwitchSettingsTile(
      settingKey: Body.keyDarkMode,
      title: 'Mode Sombre',
      leading: const OptionIcons(
        icon: Icons.brightness_4_rounded,
        bgColour: Colors.blueAccent,
      ),
      onChange: (isDark) {
        actualTheme.toggleTheme();
      });
}
