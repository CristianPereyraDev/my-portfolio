import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return widget.skills.isNotEmpty
        ? CarouselSlider.builder(
            itemCount: widget.skills.length,
            itemBuilder: (context, index, page) => ListTile(
              dense: false,
              leading: SvgPicture.network(
                widget.skills[index].imageURL,
                width: 50.0,
                height: 50.0,
              ),
              title: Text(widget.skills[index].name),
            ),
            options:
                CarouselOptions(autoPlay: true, scrollDirection: Axis.vertical),
          )
        : const Text('Not skills provided');
  }
}
