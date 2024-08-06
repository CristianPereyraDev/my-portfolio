import 'package:flutter/material.dart';
import 'package:my_portfolio/models/skill_model.dart';

class SkillLabel extends StatelessWidget {
  const SkillLabel({super.key, required this.skill});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodySmall;

    return DefaultTextStyle(
      style: defaultTextStyle!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  skill.name,
                  textScaler: const TextScaler.linear(1.0),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            LinearProgressIndicator(
              value: skill.level,
              minHeight: 6.0,
              backgroundColor: Theme.of(context).colorScheme.inverseSurface,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            )
          ],
        ),
      ),
    );
  }
}
