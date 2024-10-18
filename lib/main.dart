import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:otaku_movie_app/tabbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otaku_movie_app/mobx_store.dart';

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
  final MovieStore store = MovieStore(); // Shared instance of MovieStore

  void setLocale(Locale locale) {
    store.selectedLanguage = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return CupertinoApp(
          locale: Locale(store.selectedLanguage),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: CupertinoThemeData(
            brightness: store.isDarkMode ? Brightness.dark : Brightness.light, // Use MobX store for theme management
          ),
          home: MainTabBar(
            isDarkMode: store.isDarkMode,
            toggleTheme: store.toggleTheme,
            setLocale: setLocale,
            store: store,
          ),
        );
      },
    );
  }
}
