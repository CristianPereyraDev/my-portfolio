import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:provider/provider.dart';

class NavBarDesktop extends StatelessWidget {
  const NavBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();

    return AppBar(
      toolbarHeight: 80.0,
      title: InkWell(
        onTap: () => context.goNamed('home'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Cristian Pereyra'),
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(text: '{ ', style: TextStyle(color: Colors.amber)),
                    TextSpan(text: 'Full Stack Developer'),
                    TextSpan(text: ' }', style: TextStyle(color: Colors.amber))
                  ]),
              textScaleFactor: .9,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.go("/"),
          child: const Text("Home"),
        ),
        TextButton(
          onPressed: () => context.go("/work"),
          child: const Text("Work"),
        ),
        TextButton(
          onPressed: () => context.go("/contact"),
          child: const Text("Contact"),
        ),
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
      ],
    );
  }
}
