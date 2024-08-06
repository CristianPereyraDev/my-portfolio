import 'package:flutter/material.dart';
import 'package:my_portfolio/components/background.dart';
import 'package:my_portfolio/components/responsive_content.dart';
import 'package:my_portfolio/widgets/navbar/navbar.dart';
import 'package:responsive_framework/responsive_framework.dart';

//import 'dart:developer' as developer;

class InheritedScaffold extends InheritedWidget {
  const InheritedScaffold(
      {super.key, required this.data, required super.child});

  final MainScaffoldState data;

  @override
  bool updateShouldNotify(InheritedScaffold oldWidget) {
    return true;
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  static MainScaffoldState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedScaffold>()!
        .data;
  }

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  String? title = 'Home';

  void updateAppBarTitle({newTitle}) {
    setState(() {
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight =
        ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 80.0 : 60.0;

    return InheritedScaffold(
      data: this,
      child: Scaffold(
        drawer: ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)
            ? const Drawer(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: DrawerMenu(),
              )
            : null,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: ResponsiveAppBar(
            height: appBarHeight,
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Background(),
            Center(child: ResponsiveContent(content: widget.child))
          ],
        ),
      ),
    );
  }
}
