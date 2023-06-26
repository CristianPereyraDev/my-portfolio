import 'package:flutter/material.dart';
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

        if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)) {
          return FractionallySizedBox(
            heightFactor: 0.95,
            widthFactor: 0.95,
            child: Column(
              children: [
                AboutText(appSettings: appSettings),
                Expanded(child: SkillList(skills: skills))
              ],
            ),
          );
        } else {
          return FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: .95,
            child: Row(
              children: [
                // Skill list
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Text(
                        'My skills',
                        textScaleFactor: 2.0,
                      ),
                      Expanded(child: SkillList(skills: skills)),
                    ],
                  ),
                ),
                // About text
                Expanded(
                  flex: 1,
                  child: AboutText(appSettings: appSettings),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class AboutText extends StatelessWidget {
  const AboutText({
    super.key,
    required this.appSettings,
  });

  final AppSetting appSettings;

  @override
  Widget build(BuildContext context) {
    var screenWidth = ResponsiveBreakpoints.of(context).screenWidth;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80.0 * screenWidth * .001),
          topRight: Radius.elliptical(
              16.0 * screenWidth * .002, 8.0 * screenWidth * .001),
          bottomLeft: Radius.elliptical(
              16.0 * screenWidth * .002, 8.0 * screenWidth * .001),
          bottomRight: Radius.circular(80.0 * screenWidth * .001),
        ),
      ),
      padding: EdgeInsets.all(40.0 * screenWidth * .001),
      child: Text(
        appSettings.aboutText,
        textScaleFactor: ResponsiveBreakpoints.of(context).isMobile
            ? 1.0
            : ResponsiveBreakpoints.of(context).isTablet
                ? 1.1
                : 1.4,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
