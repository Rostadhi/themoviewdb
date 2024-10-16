import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/tabbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  Locale _locale = const Locale('en');

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light, // Toggle between dark and light mode
      ),
      home: MainTabBar(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
        setLocale: setLocale,
      ),
    );
  }
}
