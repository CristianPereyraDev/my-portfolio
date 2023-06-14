import 'package:flutter/material.dart';

class InitializationError extends StatelessWidget {
  const InitializationError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            'Ha ocurrido un error, por favor inténtelo de nuevo más tarde...'),
      ),
    );
  }
}
