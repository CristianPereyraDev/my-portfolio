import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/pages/main_scaffold.dart';

class DesktopIcon extends StatelessWidget {
  const DesktopIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('home');
        MainScaffold.of(context).updateAppBarTitle(newTitle: 'Home');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Cristian Pereyra'),
          RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(
                text: '{ ',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              TextSpan(
                text: 'Full Stack Developer',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              TextSpan(
                text: ' }',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              )
            ]),
            textScaleFactor: 1,
          ),
        ],
      ),
    );
  }
}
