import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  /*
  1. search bar
  2. option bar for dark mode
  3. movie highlight -> algorhtym based on my preference about anime movies
  4. popular section
  5. tabbar containing, home movies, detailed movie description like trailer etc, and bookmark
  6. filter movie in the popular section
  7. add localization for english and indonesia
  */
  @override
  Widget build(BuildContext context) {
    const color = Color.fromARGB(255, 251, 250, 247);
    return const CupertinoApp(
      title: 'OMO -> Otaku MOvie',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: MyHomePage(title: 'Otaku Movie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Left-side icon (Menu)
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.bars,
            color: CupertinoColors.black, // Set menu icon color to black
          ),
          onPressed: () {
            // Handle menu press
          },
        ),
        // Center title
        middle: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Right-side icon (Search)
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.search,
            color: CupertinoColors.black, // Set menu icon color to black
          ),
          onPressed: () {
            // Handle search press
          },
        ),
        backgroundColor: CupertinoColors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Otaku Movie',
              style: TextStyle(
                fontSize: 20,
                color: CupertinoColors.black,
              ),
            ),
            if (searchQuery.isNotEmpty)
              Text(
                'Search results for: $searchQuery',
                style: const TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
