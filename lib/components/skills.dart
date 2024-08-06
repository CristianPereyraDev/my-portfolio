import 'package:flutter/material.dart';
import 'package:my_portfolio/components/skill_label.dart';

import '../models/skill_model.dart';

const _skillHeight = 40.0;
const _skillListHeaderHeight = 40.0;
const _skillListBodyHeight = _skillHeight * 7;
const _skillListWidth = 400.0;
const _skillListBodyVerticalPadding = 8.0;
const _skillListBodyHorizontalPadding = 8.0;

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
    final bgColorHeader = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);
    final titleColor = Theme.of(context).colorScheme.secondary;

    final skills = CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: Color.fromRGBO(34, 34, 34, 1),
                  ),
                ),
              ),
              child: SkillLabel(
                skill: widget.skills[index],
              ),
            ),
            childCount: widget.skills.length,
          ),
        )
      ],
    );

    return widget.skills.isNotEmpty
        ? Center(
            child: SizedBox(
              width: _skillListWidth,
              height: _skillListHeaderHeight +
                  _skillListBodyHeight +
                  _skillListBodyVerticalPadding,
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10.0,
                child: Column(
                  children: [
                    // Header card
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: bgColorHeader,
                        border: const Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(36, 36, 36, 1.0),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: Center(
                        child: Text(
                          "My Skills",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: titleColor,
                                  ),
                        ),
                      ),
                    ),
                    // Body card
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: _skillListBodyHorizontalPadding,
                          right: _skillListBodyHorizontalPadding,
                          bottom: _skillListBodyVerticalPadding,
                        ),
                        child: skills,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Text('Not skills provided');
  }
}
