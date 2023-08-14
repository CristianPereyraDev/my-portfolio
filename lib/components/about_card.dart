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
    var screenWidth = ResponsiveBreakpoints.of(context).screenWidth;
    var bgColor = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);

    return Card(
      elevation: 10.0,
      color: bgColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0 * screenWidth * .001),
          topRight: Radius.circular(16.0 * screenWidth * .001),
          bottomLeft: Radius.circular(64.0 * screenWidth * .001),
          bottomRight: Radius.circular(4.0 * screenWidth * .001),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(40.0 * screenWidth * .001),
        child: Text(
          appSettings.aboutText,
          textScaleFactor: ResponsiveBreakpoints.of(context).isMobile
              ? 1.0
              : ResponsiveBreakpoints.of(context).isTablet
                  ? 1.1
                  : 1.2,
        ),
      ),
    );
  }
}
