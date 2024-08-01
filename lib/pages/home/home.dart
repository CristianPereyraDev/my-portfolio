import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';

import '../../components/skills.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Skill>> futureSkills;

  @override
  void initState() {
    super.initState();
    futureSkills = FirebaseService().getSkills();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([futureSkills]),
      builder: (context, snapshot) {
        List<Skill> skills;

        if (!snapshot.hasData && !snapshot.hasError) {
          return const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          skills = ConfigGeneral.skills;
        } else if (snapshot.hasData && snapshot.data![0].isEmpty) {
          skills = ConfigGeneral.skills;
        } else {
          skills = snapshot.data![0];
        }

        return SkillList(skills: skills);
      },
    );
  }
}
