import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:otaku_movie_app/tabbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otaku_movie_app/mobx_store.dart';
import 'package:otaku_movie_app/routing/app_routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MovieStore store = MovieStore();

  // Initialize router with store and dark mode preference
  late final AppRouter router = AppRouter(
    store: store,
    isDarkMode: store.isDarkMode,
    title: 'App Title', // Specify any general title if needed
  );

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
            brightness: store.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: MainTabBar(
            isDarkMode: store.isDarkMode,
            toggleTheme: store.toggleTheme,
            setLocale: setLocale,
            store: store,
            router: router,
          ),
        );
      },
    );
  }
}
