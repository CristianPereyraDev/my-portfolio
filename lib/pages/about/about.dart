import 'package:flutter/material.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appSettings = context.read<AppSetting>();
    return Center(child: Text(appSettings.aboutText));
  }
}
