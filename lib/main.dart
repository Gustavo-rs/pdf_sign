import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool variavel = false;
  double limitAt = 0.0;
  double limitLa = 0.0;
  double value = 90.0;
  bool isExpanded = false;

  List<Image> image = [];
  List<double> altura = [];
  List<double> largura = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 9;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomSheet: Container(
        height: 100,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Draggable<Image>(
                onDragEnd: (v) {
                  setState(() {
                    if (v.wasAccepted) {
                      largura.add(v.offset.dx);
                      altura.add(v.offset.dy);
                    }
                  });
                },
                data: Image.asset(
                  'assets/sign.png',
                  width: value,
                  height: value,
                ),
                feedback: Image.asset(
                  'assets/sign.png',
                  width: value,
                  height: value,
                ),
                childWhenDragging: Image.asset(
                  'assets/sign.png',
                  width: 100,
                  height: 100,
                ),
                child: Image.asset(
                  'assets/sign.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isExpanded = true;
                  });
                  showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      isDismissible: false,
                      isScrollControlled: true,
                      builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * .6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                              Image.asset(
                                'assets/sign.png',
                                width: value,
                                height: value,
                              ),
                              Slider(
                                value: value,
                                max: 180.0,
                                min: 40.0,
                                onChanged: (v) {
                                  setState(() {
                                    value = v;
                                  });
                                },
                              ),
                            ],
                          )));
                },
                child: const Text("Configurações"))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15),
              ]),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Stack(children: [
                DragTarget<Image>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Stack(
                      children: [
                        for (int i = 0; i < largura.length; i++)
                          Positioned(
                            left: largura[i],
                            top: altura[i] - (height * 0.120),
                            child: Stack(children: [
                              image[i],
                              Positioned(
                                right: 0,
                                top: -10,
                                child: isExpanded
                                    ? Container()
                                    : IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {});
                                          largura.removeAt(i);
                                          altura.removeAt(i);
                                          image.removeAt(i);
                                        },
                                      ),
                              ),
                            ]),
                          ),
                      ],
                    );
                  },
                  onAccept: (Image data) {
                    setState(() {
                      image.add(data);
                    });
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
