import 'package:flutter/material.dart';
import 'package:my_portfolio/components/about_card.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../components/skills.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    final appSettings = context.read<AppSetting>();
    var responsiveBreakpoints = ResponsiveBreakpoints.of(context);

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

        // TABLETS AND PHONES
        if (responsiveBreakpoints.smallerOrEqualTo(TABLET)) {
          return FractionallySizedBox(
            heightFactor: 0.95,
            widthFactor: 0.95,
            child: Column(
              children: [
                AboutCard(appSettings: appSettings),
                Expanded(
                  child: SkillList(skills: skills),
                )
              ],
            ),
          );
        } else {
          // DESKTOP
          return FractionallySizedBox(
            heightFactor: 0.9,
            widthFactor: .95,
            child: Row(
              children: [
                // Skill list
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Text(
                        'My skills',
                        textScaleFactor: 2.0,
                        style: TextStyle(
                          shadows: [
                            Shadow(offset: Offset(-3.0, 0.0), blurRadius: 2.0)
                          ],
                        ),
                      ),
                      Expanded(child: SkillList(skills: skills)),
                    ],
                  ),
                ),
                // About text
                Expanded(
                  flex: 1,
                  child: SizedBox.expand(
                    child: AboutCard(appSettings: appSettings),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
