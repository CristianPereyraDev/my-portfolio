import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/models/skill_model.dart';

class Work {
  final String name;
  final String description;
  final String image;
  final Timestamp released;
  final String type;
  final String url;
  final List<Skill>? skills;

  const Work(
      {this.skills,
      required this.name,
      required this.image,
      required this.description,
      required this.released,
      required this.type,
      required this.url});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
        skills: json['skills'] != null
            ? (json['skills'] as List)
                .map((skill) => Skill.fromJson(skill))
                .toList()
            : [],
        name: json['name'],
        description: json['description'] ?? "",
        image: json['image'] ?? "",
        released: json['released'],
        type: json['type'],
        url: json['url']);
  }
}
