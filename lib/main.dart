import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/main_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Creat3D',
    debugShowCheckedModeBanner: false,
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
    home: const MainView(),
  );
}
