import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/components/dialogs.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigGeneral {
  static const aboutText =
      'Mi interés por las Ciencias de la Computación fue creciendo a medida que fui adentrándome en este maravilloso mundo y desde entonces busco el equilibrio de conocimiento tecnológico que me permita dar soluciones eficientes.';

  static const skills = [
    Skill(
      name: 'Javacript',
      description: '',
      imageURL:
          'http://res.cloudinary.com/drwmwymbb/image/upload/v1685384055/logo-javascript_ds5lsg.svg',
    ),
    Skill(
      name: 'React.js',
      description: '',
      imageURL:
          'http://res.cloudinary.com/drwmwymbb/image/upload/v1685384055/react-2_ja0ty3.svg',
    ),
    Skill(
      name: 'Node.js',
      description: '',
      imageURL:
          'http://res.cloudinary.com/drwmwymbb/image/upload/v1685429864/nodejs.svg.svg',
    ),
  ];

  static final works = [
    Work(
      name: 'Cyberzon3',
      released: Timestamp.fromDate(DateTime(2023)),
      type: 'E-commerce',
      url: 'https://cyberzon3.com/',
    )
  ];

  static Future<void> launchGeneralUrl(url, BuildContext context) async {
    launchUrl(url).catchError((error) {
      showCustomDialog(context, 'Error', Text('Could not launch $url'));
      return false;
    });
  }
}
