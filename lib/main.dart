import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/main_view.dart';
import 'generated/l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('es');

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creat3D',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        primaryColor: const Color(0xFF4F46E5),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: const Color(0xFF111827),
            displayColor: const Color(0xFF111827),
          ),
        ),
      ),
      home: MainView(onLocaleChange: _changeLanguage),
    );
  }
}
