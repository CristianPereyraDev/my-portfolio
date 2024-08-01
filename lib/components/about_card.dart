import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_portfolio/models/app_model.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    super.key,
    required this.appSettings,
  });

  final AppSetting appSettings;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge;
    final textScaler = ResponsiveBreakpoints.of(context).isMobile
        ? 1.0
        : ResponsiveBreakpoints.of(context).isTablet
            ? 1.1
            : 1.2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "About",
          style: titleStyle?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            shadows: [const Shadow(blurRadius: 3.0, offset: Offset(0.0, 2.0))]
          ),          
          textScaler: TextScaler.linear(textScaler),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          appSettings.aboutText,
          style: textTheme.bodySmall,
          textScaler: TextScaler.linear(
            textScaler,
          ),
        ),
      ],
    );
  }
}
