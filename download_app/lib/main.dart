import 'package:download_app/ui/providers/theme_color_provider.dart';
import 'package:download_app/ui/screens/downloads/downloads_screen.dart';
import 'package:download_app/ui/screens/settings/settings_screen.dart';
import 'package:download_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;
  final ThemeColorProvider _themeProvider = ThemeColorProvider(currentThemeColor);

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  late final List<Widget> _pages = [
    DownloadsScreen(themeProvider: _themeProvider),
    SettingsScreen(themeProvider: _themeProvider)
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeProvider,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              selectedItemColor: _themeProvider.selected.color,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Downloads'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Settings'),
              ],
            ),
          ),
        );
      },
    );
  }
}
