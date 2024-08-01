import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ProjectCard extends StatelessWidget {
  final Work work;

  const ProjectCard({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ProjectHeaderDelegate(work),
    );
  }
}

const _projectCardMaxHeight = 400.0;
const _projectCardMinHeight = 150.0;

class ProjectHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Work work;

  ProjectHeaderDelegate(this.work);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bgColorHeader = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);

    return Column(
      children: [
        // Project header
        Container(
          height: 50.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: bgColorHeader,
            border: const BorderDirectional(
              bottom: BorderSide(
                color: Color.fromRGBO(36, 36, 36, 1.0),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _WorkLabel(
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
        ),
        // Project image
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.network(
                work.image,
                errorBuilder: (context, error, stackTrace) => const Text('😢'),
              ),
            ),
          ),
        ),
        // Project description.
        Container(
          height: 100.0,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(49, 49, 49, 1),
            border: BorderDirectional(
              top: BorderSide(
                color: Color.fromRGBO(36, 36, 36, 1.0),
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  work.description,
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
              Row(
                children: work.skills != null
                    ? List.generate(
                        work.skills!.length,
                        (i) => Padding(
                          padding: EdgeInsets.only(right: i < work.skills!.length - 1 ? 4.0 : 0.0),
                          child: SkillLabel(
                            name: work.skills![i].name,
                          ),
                        ),
                      )
                    : [],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => _projectCardMaxHeight;

  @override
  double get minExtent => _projectCardMinHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
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
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color.fromRGBO(46, 46, 41, 1.0),
            ),
      ),
    );
  }
}

class _WorkLabel extends StatelessWidget {
  const _WorkLabel(
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
            style: const TextStyle(color: Color.fromRGBO(190, 140, 124, 1.0)),
            textScaler: TextScaler.linear(fontScale),
          ),
        ],
      ),
    );
  }
}
