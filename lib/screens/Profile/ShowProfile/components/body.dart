import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import '../../../../components/icon_options.dart';
import 'background.dart';
import 'package:ap4_gsbmedecins_appli/themes.dart';

class Body extends StatefulWidget {
  // Cached values in order to remember the user's preferences
  static const keyDarkMode = 'key-dark-mode';
  static const keyLanguage = 'key-app-language';
  static const keyUsername = 'key-username';

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
              title: 'Préférences',
              children: <Widget>[darkModeOption(), languageOption()],
            ),
            SettingsGroup(
              title: 'Compte',
              children: <Widget>[usernameOption()],
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
        // icon: Icons.brightness_4_rounded,
        icon: Icons.dark_mode,
        bgColour: Color(0xFF642ef3),
      ),
      onChange: (isDark) {
        actualTheme.toggleTheme();
      });

  Widget usernameOption() => TextInputSettingsTile(
    settingKey: Body.keyUsername,
    title: "Nom d'utilisateur",
  );
}
