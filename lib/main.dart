import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/themes.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:my_portfolio/pages/errors/initialization_error.dart';
import 'package:my_portfolio/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_portfolio/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 5050);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppSetting>(
        future: FirebaseService().getPortfolioSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: '{ Cr-Dev }',
              theme: themeDark.copyWith(
                textTheme: GoogleFonts.secularOneTextTheme(themeDark.textTheme),
                appBarTheme: const AppBarTheme(
                  color: Color.fromRGBO(46, 46, 41, 1),
                ),
              ),
              home: const InitializationError(),
            );
          } else if (snapshot.hasData) {
            return Provider.value(
              value: snapshot.data,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: router,
                title: '{ Cr-Dev }',
                theme: themeDark.copyWith(
                  textTheme:
                      GoogleFonts.secularOneTextTheme(themeDark.textTheme),
                  appBarTheme: const AppBarTheme(
                    color: Color.fromRGBO(46, 46, 41, 1),
                  ),
                ),
                builder: (context, child) => ResponsiveBreakpoints(
                  breakpoints: const [
                    Breakpoint(start: 0, end: 450, name: MOBILE),
                    Breakpoint(start: 451, end: 800, name: TABLET),
                    Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                  ],
                  child: child!,
                ),
              ),
            );
          }
          // return Loading widget
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '{ Cr-Dev }',
            theme: themeDark.copyWith(
              textTheme: GoogleFonts.secularOneTextTheme(themeDark.textTheme),
              appBarTheme: const AppBarTheme(
                color: Color.fromRGBO(46, 46, 41, 1),
              ),
            ),
            home: const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
