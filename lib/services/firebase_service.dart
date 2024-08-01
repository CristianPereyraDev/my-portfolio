import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/models/app_model.dart';
import 'package:my_portfolio/models/skill_model.dart';
import 'package:my_portfolio/models/work_model.dart';

class FirebaseService {
  Future<AppSetting> getPortfolioSettings() async {
    final db = FirebaseFirestore.instance;
    try {
      final doc = await db.collection('settings').doc('portfolio').get();

      return AppSetting.fromJson(doc.data()!);
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
        final workData = work.data();
        final List<Map<String, dynamic>> skills = [];

        if (workData["skills"] != null) {
          // Get skills
          for (DocumentReference<Map<String, dynamic>> skill
              in workData["skills"]) {
            final skillDoc = await skill.get();
            skills.add(skillDoc.data()!);
            // final skillDoc = await db.collection('skills').doc(skill).get();
            // skills.add(Skill.fromJson(skillDoc.data()!));
          }
        }

        workData["skills"] = skills;
        result.add(Work.fromJson(workData));
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
