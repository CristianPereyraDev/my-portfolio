import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

enum Navigation {
  home(path: '/'),
  work(path: '/work'),
  contact(path: '/contact');

  const Navigation({required this.path});

  final String path;

  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...Navigation.values.map(
            (e) => TextButton(
              onPressed: () {
                // First close the drawer
                Navigator.pop(context);
                context.go(e.path);
              },
              child: Text(e.capitalizedName),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveAppBar extends StatelessWidget {
  const ResponsiveAppBar({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();

    List<Widget> actions = [];

    if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      actions = [
        ...Navigation.values.map(
          (e) => TextButton(
            onPressed: () => context.go(e.path),
            child: Text(e.capitalizedName),
          ),
        )
      ];
    }

    actions.addAll([
      const SizedBox(width: 20.0),
      // Icons
      IconButton(
        onPressed: () => ConfigGeneral.launchGeneralUrl(
            Uri.parse(appSettings.github), context),
        icon: const Icon(FontAwesomeIcons.github),
      ),
      IconButton(
        onPressed: () => ConfigGeneral.launchGeneralUrl(
            Uri.parse(appSettings.linkedin), context),
        icon: const Icon(FontAwesomeIcons.linkedin),
      )
    ]);

    return AppBar(
      toolbarHeight: height,
      title: ResponsiveBreakpoints.of(context).largerThan(TABLET)
          ? InkWell(
              onTap: () => context.goNamed('home'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cristian Pereyra'),
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                              text: '{ ',
                              style: TextStyle(color: Colors.amber)),
                          TextSpan(text: 'Full Stack Developer'),
                          TextSpan(
                              text: ' }', style: TextStyle(color: Colors.amber))
                        ]),
                    textScaleFactor: .9,
                  ),
                ],
              ),
            )
          : null,
      actions: actions,
    );
  }
}
