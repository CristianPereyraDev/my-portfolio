import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
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
  const MainScaffold({Key? key, required this.child}) : super(key: key);

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
          children: [
            Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(25, 39, 28, 1.0),
                  Color.fromRGBO(112, 141, 102, 1.0)
                ],
              ),
            )),
            WaveWidget(
              config: CustomConfig(
                gradientBegin: Alignment.topCenter,
                gradientEnd: Alignment.centerLeft,
                gradients: [
                  [
                    const Color.fromARGB(128, 77, 60, 45),
                    const Color.fromARGB(255, 141, 84, 48),
                  ],
                  [
                    const Color.fromARGB(255, 97, 49, 19),
                    const Color.fromARGB(128, 66, 42, 20),
                  ],
                  [
                    const Color.fromARGB(255, 97, 68, 26),
                    const Color.fromARGB(255, 27, 29, 5),
                  ],
                ],
                durations: [30000, 25000, 15000],
                heightPercentages: [0.7, 0.75, 0.8],
              ),
              size: const Size(double.infinity, double.infinity),
              heightPercentage: 1.0,
              waveFrequency: 8.0,
              waveAmplitude: 10.0,
              wavePhase: 1.0,
            ),
            Container(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
