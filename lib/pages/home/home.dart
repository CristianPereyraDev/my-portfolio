import 'package:flutter/material.dart';
import 'package:my_portfolio/components/about.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';

import '../../components/skills.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Skill>> futureSkills;
  late Future<String> futureAbout;

  @override
  void initState() {
    super.initState();
    futureSkills = FirebaseService().getSkills();
    futureAbout = FirebaseService().getPortfolioSettings('aboutText');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: Future.wait([futureAbout, futureSkills]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final aboutText = snapshot.data![0] as String;
            final skills = snapshot.data![1] as List<Skill>;
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(child: SkillList(skills: skills)),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[300],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(80.0),
                          bottomLeft: Radius.elliptical(16.0, 8.0)),
                    ),
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      aboutText,
                      textScaleFactor: 1.5,
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const About();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
