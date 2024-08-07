import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/components/desktop_icon.dart';
import 'package:my_portfolio/components/navigation_button.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:my_portfolio/pages/main_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

//import 'dart:developer' as developer;

enum Navigation {
  home(path: '/'),
  projects(path: '/work'),
  contact(path: '/contact');

  const Navigation({required this.path});

  final String path;

  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final emailContactStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...Navigation.values.map(
            (e) => TextButton(
              onPressed: () {
                // First close the drawer
                Navigator.pop(context);
                context.go(e.path);
                MainScaffold.of(context)
                    .updateAppBarTitle(newTitle: e.capitalizedName);
              },
              child: Text(e.capitalizedName),
            ),
          ),
          const Expanded(child: SizedBox(width: 10.0)),
          const Divider(height: 1.0, thickness: 1.0),
          const SizedBox(height: 10.0),
          const DesktopIcon(),
          const SizedBox(height: 10.0),
          Text(
            'cristian.pereyra.dev@gmail.com',
            style: emailContactStyle,
          )
        ],
      ),
    );
  }
}

class ResponsiveAppBar extends StatelessWidget {
  const ResponsiveAppBar({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();
    var responsiveBreakpoints = ResponsiveBreakpoints.of(context);

    List<Widget> actions = [];

    if (responsiveBreakpoints.largerThan(TABLET)) {
      actions = [
        ...Navigation.values.map(
          (e) => NavigationButton(
            text: e.capitalizedName,
            path: e.path,
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
      centerTitle: true,
      title:
          responsiveBreakpoints.largerThan(TABLET) ? null : const AppBarTitle(),
      leadingWidth: responsiveBreakpoints.largerThan(TABLET) ? 180.0 : 56.0,
      leading: Builder(builder: (context) {
        return responsiveBreakpoints.largerThan(TABLET)
            ? const DesktopIcon()
            : IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              );
      }),
      actions: actions,
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var title = MainScaffold.of(context).title ?? '';

    return Text(title);
  }
}
