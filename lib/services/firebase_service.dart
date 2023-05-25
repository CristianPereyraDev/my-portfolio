import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/models/work_model.dart';

class FirebaseService {
  Future<String> getPortfolioSettings(String field) async {
    final db = FirebaseFirestore.instance;
    try {
      final doc = await db.collection('settings').doc('portfolio').get();
      return doc.get(field);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Work>> getWorks() async {
    final db = FirebaseFirestore.instance;
    List<Work> result = [];

    try {
      final works = await db.collection('works').get();

      for (var work in works.docs) {
        result.add(Work.fromJson(work.data()));
      }

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Skill>> getSkills() async {
    final db = FirebaseFirestore.instance;
    List<Skill> result = [];

    try {
      final skills = await db.collection('skills').get();

      for (var skill in skills.docs) {
        result.add(Skill.fromJson(skill.data()));
      }

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
