import 'package:flutter/material.dart';

class TranslucentCard extends StatelessWidget {
  const TranslucentCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var bgColor = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);

    return Card(
      color: bgColor.withOpacity(0.8),
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
