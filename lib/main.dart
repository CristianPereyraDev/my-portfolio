import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/themes.dart';
import 'package:my_portfolio/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Cr',
      theme: themeDark!.copyWith(
          textTheme: GoogleFonts.lobsterTextTheme(themeDark!.textTheme)),
    );
  }
}
