import 'package:flutter/material.dart';
import 'package:my_portfolio/components/project_card.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';

const _scrollViewHeight = 600.0;
const _scrollViewWidth = 400.0;

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  late Future<List<Work>> futureWorks;

  @override
  void initState() {
    super.initState();
    futureWorks = FirebaseService().getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureWorks,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final works = snapshot.data ?? [];

          return Center(
            child: SizedBox(
              height: _scrollViewHeight,
              width: _scrollViewWidth,
              child: Card(
                elevation: 4.0,
                clipBehavior: Clip.antiAlias,
                child: CustomScrollView(
                  slivers: _makeSliverListFromWorks(works),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text('Error while fetching works. 😢'),
                Text(snapshot.error.toString()),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          return Center(
            child: Column(
              children: [
                const Text('There are no Works to show. 😢'),
                Text(snapshot.error.toString()),
              ],
            ),
          );
        }
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

List<Widget> _makeSliverListFromWorks(List<Work> works) {
  List<Widget> slivers = [];

  for (var work in works) {
    slivers
      ..add(
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: ProjectHeaderDelegate(
            work: work,
            minHeight: 50.0,
            maxHeight: 300.0,
          ),
        ),
      )
      ..add(
        SliverList(
          delegate: SliverChildListDelegate(
            [ProjectDescription(work: work)],
          ),
        ),
      );
  }

  return slivers;
}


