import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class InitializationError extends StatelessWidget {
  const InitializationError({super.key});

  @override
  Widget build(BuildContext context) {
    var breakpoints = ResponsiveBreakpoints.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Ha ocurrido un error, por favor inténtelo de nuevo más tarde...',
            textScaler: TextScaler.linear(
                breakpoints.smallerOrEqualTo(MOBILE) ? 1.0 : 1.2),
          ),
        ),
      ),
    );
  }
}
