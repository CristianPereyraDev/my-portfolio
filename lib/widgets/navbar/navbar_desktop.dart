import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarDesktop extends StatelessWidget {
  const NavBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.0,
      title: Column(
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
      ],
    );
  }
}
