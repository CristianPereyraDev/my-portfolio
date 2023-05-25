import 'package:flutter/material.dart';
import 'package:my_portfolio/services/firebase_service.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
            return Text('${snapshot.error}');
          }
          // Loading.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
