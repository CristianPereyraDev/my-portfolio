import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ProjectHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Work work;
  final double minHeight;
  final double maxHeight;

  ProjectHeaderDelegate({
    required this.work,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bgColor = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Column(
        children: [
          // Project header
          ProjectHeader(height: minHeight, work: work),
          // Project image
          Expanded(
            child: AnimatedOpacity(
              opacity: shrinkOffset / (maxHeight - minHeight) < 0.7 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: FlexibleProjectSpace(work: work),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({
    super.key,
    required this.work,
    required this.height,
  });

  final Work work;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProjectLabel(
            name: work.name,
            type: work.type,
            released: work.released,
            url: work.url,
          ),
          TextButton(
            onPressed: () => {
              ConfigGeneral.launchGeneralUrl(
                Uri.parse(work.url),
                context,
              )
            },
            child: const Text("Link"),
          ),
        ],
      ),
    );
  }
}

class FlexibleProjectSpace extends StatelessWidget {
  const FlexibleProjectSpace({
    super.key,
    required this.work,
  });

  final Work work;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Image.network(
          work.image,
          errorBuilder: (context, error, stackTrace) => const Text('😢'),
        ),
      ),
    );
  }
}

class ProjectDescription extends StatelessWidget {
  const ProjectDescription({
    super.key,
    required this.work,
  });

  final Work work;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const BorderDirectional(
          top: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(36, 36, 36, 1.0),
          ),
          bottom: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(36, 36, 36, 1.0),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            work.description,
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: work.skills != null
                ? List.generate(
                    work.skills!.length,
                    (i) => Padding(
                      padding: EdgeInsets.only(
                          right: i < work.skills!.length - 1 ? 4.0 : 0.0),
                      child: SkillLabel(
                        name: work.skills![i].name,
                      ),
                    ),
                  )
                : [],
          )
        ],
      ),
    );
  }
}

class SkillLabel extends StatelessWidget {
  const SkillLabel({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(194, 205, 73, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color.fromARGB(255, 56, 56, 20),
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class ProjectLabel extends StatelessWidget {
  const ProjectLabel(
      {super.key,
      required this.name,
      required this.type,
      required this.released,
      required this.url});

  final String name;
  final String type;
  final Timestamp released;
  final String url;

  @override
  Widget build(BuildContext context) {
    var breakpoints = ResponsiveBreakpoints.of(context);
    final fontScale = breakpoints.smallerOrEqualTo(MOBILE)
        ? 0.8
        : breakpoints.smallerOrEqualTo(TABLET)
            ? 1.0
            : 1.2;

    return DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            released.toDate().year.toString(),
            textScaler: TextScaler.linear(fontScale),
          ),
          Text(
            ' | ',
            textScaler: TextScaler.linear(fontScale),
          ),
          Text(
            name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
            textScaler: TextScaler.linear(fontScale),
          ),
        ],
      ),
    );
  }
}
