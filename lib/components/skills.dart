import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/components/skill_card.dart';

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
            itemBuilder: (context, index, page) {
              return SkillCard(
                title: widget.skills[index].name,
                description: widget.skills[index].description,
                imageUrl: widget.skills[index].imageURL,
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              scrollDirection: Axis.vertical,
              autoPlayCurve: Curves.linear,
            ),
          )
        : const Text('Not skills provided');
  }
}
