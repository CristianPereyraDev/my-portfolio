import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/components/dialogs.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class ConfigGeneral {
  static const aboutText =
      'Mi interés por las Ciencias de la Computación fue creciendo a medida que fui adentrándome en este maravilloso mundo y desde entonces busco el equilibrio de conocimiento tecnológico que me permita dar soluciones eficientes.';

  static const skills = [
    Skill(
      name: 'Javacript',
      description: '',
      imageURL:
          'https://res.cloudinary.com/drwmwymbb/image/upload/fl_preserve_transparency/v1685384054/Icons/icons8-javascript_1_scczhs.webp',
    ),
    Skill(
      name: 'React.js',
      description:
          'Biblioteca Javascript de código abierto diseñada para crear interfaces de usuario con el objetivo de facilitar el desarrollo de aplicaciones en una sola página',
      imageURL:
          'https://res.cloudinary.com/drwmwymbb/image/upload/c_scale,fl_preserve_transparency,w_128/v1685384055/Icons/react-2_ja0ty3.webp',
    ),
    Skill(
      name: 'Node.js',
      description: '',
      imageURL:
          'https://res.cloudinary.com/drwmwymbb/image/upload/v1685429864/Icons/nodejs.webp',
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

  static Future<void> launchGeneralUrl(Uri url, BuildContext context) async {
    launchUrl(url).catchError((error) {
      showCustomDialog(context, 'Error', Text('Could not launch $url'));
      return false;
    });
  }

  Future<bool> validateImageUrl(String imageUrl) async {
    http.Response res;

    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
