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

class ResponsiveAppBar extends StatefulWidget {
  const ResponsiveAppBar({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar> {
  String title = 'Home';

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();

    List<Widget> actions = [];

    if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      actions = [
        ...Navigation.values.map(
          (e) => TextButton(
            onPressed: () {
              context.go(e.path);
              setState(() {
                title = e.capitalizedName;
              });
            },
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
      toolbarHeight: widget.height,
      centerTitle: true,
      title: Text(title),
      leadingWidth: 180.0,
      leading: InkWell(
        onTap: () => context.goNamed('home'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Cristian Pereyra'),
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '{ ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    TextSpan(
                      text: 'Full Stack Developer',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    TextSpan(
                      text: ' }',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ]),
              textScaleFactor: 1,
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
