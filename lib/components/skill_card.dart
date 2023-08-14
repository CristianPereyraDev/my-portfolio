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
    final bgColorHeader = Theme.of(context).appBarTheme.backgroundColor ??
        const Color.fromRGBO(46, 46, 41, 1.0);

    return Center(
      child: SizedBox(
        width: 350,
        height: 300,
        child: Card(
          elevation: 10.0,
          color: Colors.transparent,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromRGBO(109, 109, 63, 1.0)),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              // Header Card
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: bgColorHeader,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: const [
                    BoxShadow(offset: Offset(0.0, 2.0), blurRadius: 2.0)
                  ],
                ),
                child: Stack(
                  children: [
                    Align(
                      child: Text(
                        title,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return SizedBox(
                          height: constraints.maxHeight - 4.0,
                          width: constraints.maxHeight - 4.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(21, 21, 21, 1.0),
                              borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(16.0),
                                bottomEnd: Radius.circular(4.0),
                                topStart: Radius.circular(4.0),
                                topEnd: Radius.circular(12.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 2.0,
                                )
                              ],
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(imageUrl),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
              // Body Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(43, 51, 29, .8),
                        Color.fromRGBO(72, 72, 15, .8)
                      ],
                    ),
                  ),
                  child: Center(child: Text(description)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
