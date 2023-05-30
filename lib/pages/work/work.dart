import 'package:flutter/material.dart';
import 'package:my_portfolio/configs/general.dart';
import 'package:my_portfolio/models/work_model.dart';
import 'package:my_portfolio/services/firebase_service.dart';

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
            debugPrint('hasData');
            return DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 24),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    TextButton(
                      onPressed: () => {
                        ConfigGeneral.launchGeneralUrl(
                          Uri.parse(snapshot.data![index].url),
                          context,
                        )
                      },
                      child: Text(
                        ConfigGeneral.works[index].name,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const Text(' | '),
                    Text(snapshot.data![index].type),
                    const Text(' | '),
                    Text(
                      ConfigGeneral.works[index].released
                          .toDate()
                          .year
                          .toString(),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError || snapshot.hasData) {
            return DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 24),
              child: ListView.builder(
                itemCount: ConfigGeneral.works.length,
                itemBuilder: (context, index) => Center(
                  child: FractionallySizedBox(
                    widthFactor: .8,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () => {
                            ConfigGeneral.launchGeneralUrl(
                              Uri.parse(ConfigGeneral.works[index].url),
                              context,
                            )
                          },
                          child: Text(
                            ConfigGeneral.works[index].name,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const Text(' | '),
                        Text(ConfigGeneral.works[index].type),
                        const Text(' | '),
                        Text(ConfigGeneral.works[index].released
                            .toDate()
                            .year
                            .toString()),
                      ],
                    ),
                  ),
                ),
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
      ),
    );
  }
}
