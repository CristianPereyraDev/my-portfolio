import 'package:flutter/material.dart';
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
    return Center(
      child: FutureBuilder(
        future: futureWorks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 24),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    Text(snapshot.data![index].name),
                    const Text(' | '),
                    Text(snapshot.data![index].type),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
