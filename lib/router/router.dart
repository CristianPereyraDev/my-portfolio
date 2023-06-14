import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/pages/contact/contact.dart';
import 'package:my_portfolio/pages/errors/initialization_error.dart';
import 'package:my_portfolio/pages/home/home.dart';
import 'package:my_portfolio/pages/main_scaffold.dart';
import 'package:my_portfolio/pages/work/work.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/",
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: "/",
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/work",
          builder: (context, state) => const WorkPage(),
        ),
        GoRoute(
          path: "/contact",
          builder: (context, state) => const Contact(),
        ),
        GoRoute(
          path: '/initError',
          name: 'InitError',
          builder: (context, state) => const InitializationError(),
        )
      ],
    )
  ],
);
