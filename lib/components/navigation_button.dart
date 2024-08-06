import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/router/router.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({super.key, required this.text, required this.path});

  final String text;
  final String path;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  TextDecoration textDecoration = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    if (GoRouter.of(context).location == widget.path) {
      textDecoration = TextDecoration.underline;
    }

    GoRouter.of(context).routerDelegate.addListener(() {
      if (GoRouter.of(context).location == widget.path) {
        setState(() {
          textDecoration = TextDecoration.underline;
        });
      } else {
        setState(() {
          textDecoration = TextDecoration.none;
        });
      }
    });

    return TextButton(
      onPressed: () {
        context.go(widget.path);
      },
      child: Text(
        widget.text,
        style: TextStyle(
          decoration: textDecoration,
          decorationColor: Theme.of(context).colorScheme.secondary,
          decorationThickness: 2.0,
        ),
      ),
    );
  }
}
