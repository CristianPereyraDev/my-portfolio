import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/navbar/navbar_desktop.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Add Key
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: NavBarDesktop(),
      ),
      body: child,
    );
  }
}
