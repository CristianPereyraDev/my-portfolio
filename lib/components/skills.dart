import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
              return ListTile(
                isThreeLine: widget.skills[index].description.isNotEmpty,
                dense: false,
                leading: Image.network(
                  widget.skills[index].imageURL,
                ),
                title: Text(widget.skills[index].name),
                subtitle: Text(widget.skills[index].description),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              scrollDirection: Axis.vertical,
              autoPlayCurve: Curves.linear,
            ),
          )
        : const Text('Not skills provided');
  }
}
