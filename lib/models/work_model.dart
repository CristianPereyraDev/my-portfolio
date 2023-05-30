import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  final String name;
  final Timestamp released;
  final String type;
  final String url;

  const Work(
      {required this.name,
      required this.released,
      required this.type,
      required this.url});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
        name: json['name'],
        released: json['released'],
        type: json['type'],
        url: json['url']);
  }
}
