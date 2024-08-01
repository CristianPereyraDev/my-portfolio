import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  const SkillCard(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl});

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodySmall;

    return DefaultTextStyle(
      style: defaultTextStyle!,
      child: Row(          
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: defaultTextStyle.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            textScaler: const TextScaler.linear(1.0),
          ),
        ],
      ),
    );
  }
}
