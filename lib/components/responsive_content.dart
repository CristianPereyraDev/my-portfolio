import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/router/router.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/components/about_card.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();
    final responsiveBreakpoints = ResponsiveBreakpoints.of(context);    
    final location = GoRouter.of(context).location;

    // TABLETS AND PHONES
    if (responsiveBreakpoints.smallerOrEqualTo(TABLET)) {
      return FractionallySizedBox(
        heightFactor: 0.98,
        widthFactor: 0.95,
        child: location == "/" ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AboutCard(appSettings: appSettings),
            content,
          ],
        ): content,
      );
    } else {
      // DESKTOP
      return FractionallySizedBox(
        heightFactor: 0.9,
        widthFactor: .95,
        child: Row(
          children: [
            // About text
            Expanded(              
              child: Center(child: AboutCard(appSettings: appSettings)),
            ),
            const SizedBox(
              width: 16.0,
            ),
            // Skill list
            Expanded(              
              child: content,
            ),
          ],
        ),
      );
    }
  }
}
