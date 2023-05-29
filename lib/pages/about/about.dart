import 'package:flutter/material.dart';
import 'package:my_portfolio/components/about.dart';
import 'package:my_portfolio/services/firebase_service.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late Future<String> futureAboutText;

  @override
  void initState() {
    super.initState();
    futureAboutText = FirebaseService().getPortfolioSettings('aboutText');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: futureAboutText,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data ?? 'Not data provided');
          } else if (snapshot.hasError) {
            return const About();
          }
          // Loading.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
