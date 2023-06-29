import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';
import 'package:responsive_framework/responsive_framework.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

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
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: FutureBuilder(
        future: futureWorks,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final works = snapshot.data ?? [];
            return ListView.builder(
              itemCount: works.length,
              itemBuilder: (context, index) => WorkLabel(work: works[index]),
            );
          } else if (snapshot.hasError || snapshot.hasData) {
            return ListView.builder(
              itemCount: ConfigGeneral.works.length,
              itemBuilder: (context, index) =>
                  WorkLabel(work: ConfigGeneral.works[index]),
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
      ),
    );
  }
}

class WorkLabel extends StatelessWidget {
  const WorkLabel({Key? key, required this.work}) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    var breakpoints = ResponsiveBreakpoints.of(context);
    final fontSize = breakpoints.smallerOrEqualTo(MOBILE)
        ? 18.0
        : breakpoints.smallerOrEqualTo(TABLET)
            ? 22.0
            : 24.0;

    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: fontSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () => {
                ConfigGeneral.launchGeneralUrl(
                  Uri.parse(work.url),
                  context,
                )
              },
              child: Text(
                work.name,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ),
          const Text(' | '),
          Flexible(child: Text(work.type)),
          const Text(' | '),
          Text(work.released.toDate().year.toString()),
        ],
      ),
    );
  }
}
