import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/skill_model.dart';

class SkillList extends StatefulWidget {
  const SkillList({
    super.key,
    required this.skills,
  });

  final List<Skill> skills;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: CarouselSlider.builder(
        itemCount: widget.skills.length,
        itemBuilder: (context, index, page) => ListTile(
          dense: false,
          leading: FaIcon(
              IconDataBrands(int.parse(widget.skills[index].fontAwesomeCode))),
          title: Text(widget.skills[index].name),
        ),
        options:
            CarouselOptions(autoPlay: true, scrollDirection: Axis.vertical),
      ),
    );
  }
}
