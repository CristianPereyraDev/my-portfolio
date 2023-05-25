import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  final String name;
  final Timestamp released;
  final String type;

  const Work({required this.name, required this.released, required this.type});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      name: json['name'],
      released: json['released'],
      type: json['type'],
    );
  }
}
