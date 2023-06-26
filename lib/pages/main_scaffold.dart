import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/navbar/navbar.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appBarHeight =
        ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 80.0 : 60.0;

    return Scaffold(
      drawer: ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)
          ? const Drawer(
              child: DrawerMenu(),
            )
          : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: ResponsiveAppBar(
          height: appBarHeight,
        ),
      ),
      body: child,
    );
  }
}
