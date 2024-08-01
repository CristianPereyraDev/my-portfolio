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
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder: _transitionAnimation,
          ),
        ),
        GoRoute(
          path: "/work",
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const WorkPage(),
            transitionsBuilder: _transitionAnimation,
          ),
        ),
        GoRoute(
          path: "/contact",
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const Contact(),
            transitionsBuilder: _transitionAnimation,
          ),
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

Widget _transitionAnimation(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
    child: child,
  );
}

extension GoRouterExtension on GoRouter {
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
