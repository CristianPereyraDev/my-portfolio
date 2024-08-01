import 'package:flutter/material.dart';
import 'package:my_portfolio/components/project_card.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';

const _scrollViewHeight = 408.0;
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
                  slivers: works
                      .map(
                        (work) => SliverPersistentHeader(
                          pinned: false,
                          floating: false,
                          delegate: ProjectHeaderDelegate(work),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError || snapshot.hasData) {
          return ListView.builder(
            itemCount: ConfigGeneral.works.length,
            itemBuilder: (context, index) => ProjectCard(
              work: ConfigGeneral.works[index],
            ),
          );
        }
        return const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
