import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_icons/animate_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCDBF4),
      appBar: AppBar(
        title: const Text('Flutter Animations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 60),
              child: AnimatedHeard(),
            ),
            SizedBox(height: 10),
            SizeTransitionList(),
            SizedBox(height: 10),
            AnimatedContainerList(),
            SizedBox(height: 10),
            VisibilityList(),
          ],
        ),
      ),
    );
  }
}

// SizeTransition стрелка через библиотеку https://pub.dev/packages/animate_icons/install

class SizeTransitionList extends StatefulWidget {
  const SizeTransitionList({Key? key}) : super(key: key);

  @override
  State<SizeTransitionList> createState() => _SizeTransitionListState();
}

class _SizeTransitionListState extends State<SizeTransitionList>
    with TickerProviderStateMixin {
  late AnimateIconController iconController;
  late AnimationController dropController;
  late Animation<double> cardController;

  bool show = false;

  @override
  void initState() {
    iconController = AnimateIconController();
    dropController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    cardController = Tween(begin: 0.0, end: 1.0).animate(dropController);
    super.initState();
  }

  @override
  void dispose() {
    dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
              title: Text('SizeTransition',
                  style: GoogleFonts.aladin(
                      textStyle: const TextStyle(fontSize: 26))),
              trailing: AnimateIcons(
                duration: const Duration(milliseconds: 500),
                controller: iconController,
                endIcon: Icons.arrow_upward,
                startIcon: Icons.arrow_downward,
                onStartIconPress: () {
                  show == true;
                  dropController.forward();
                  return true;
                },
                onEndIconPress: () {
                  show == false;
                  dropController.reverse();
                  return true;
                },
              )),
        ),
        SizeTransition(
          sizeFactor: cardController,
          axis: Axis.vertical,
          axisAlignment: 1.0,
          child: Card(
            child: ListTile(
              title: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Контейнер через SizeTransition',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18))),
                    Text('Стрелка через библиотеку animate_icons',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// AnimatedContainer стрелка через RotationTransition

class AnimatedContainerList extends StatefulWidget {
  const AnimatedContainerList({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerList> createState() => _AnimatedContainerListState();
}

class _AnimatedContainerListState extends State<AnimatedContainerList>
    with TickerProviderStateMixin {
  late AnimationController dropController;
  late Animation<double> iconController;

  bool show = false;

  @override
  void initState() {
    dropController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    iconController = Tween(begin: 0.0, end: -0.5).animate(dropController);
    super.initState();
  }

  @override
  void dispose() {
    dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('AnimatedContainer',
                style: GoogleFonts.aladin(
                    textStyle: const TextStyle(fontSize: 26))),
            trailing: RotationTransition(
              turns: iconController,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    show ? dropController.reverse() : dropController.forward();
                    setState(() {
                      show = !show;
                    });
                  }),
            ),
          ),
        ),
        AnimatedContainer(
          height: show ? 80 : 0,
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: Card(
            child: ListTile(
              title: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Контейнер через AnimatedContainer',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18))),
                    Text('Стрелка через RotationTransition',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Visibility (Таким способом нет плавного появления),  стрелка через условие. Оксана скидывала пример https://dartpad.dev/?id=a2408d29a1e8c6ce7a1cef8f21e7491d

class VisibilityList extends StatefulWidget {
  const VisibilityList({Key? key}) : super(key: key);

  @override
  State<VisibilityList> createState() => _VisibilityListState();
}

class _VisibilityListState extends State<VisibilityList>
    with TickerProviderStateMixin {
  late AnimateIconController iconController;
  late AnimationController dropController;

  bool show = false;
  bool isVisible = false;

  @override
  void initState() {
    iconController = AnimateIconController();
    dropController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    super.initState();
  }

  @override
  void dispose() {
    dropController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('Visibility',
                style: GoogleFonts.aladin(
                    textStyle: const TextStyle(fontSize: 26))),
            trailing: IconButton(
                icon: Icon(
                  show ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.blue,
                ),
                onPressed: () {
                  show ? dropController.forward() : dropController.reverse();
                  setState(() {
                    isVisible = !isVisible;
                    show = !show;
                  });
                }),
            //// Стрелка через библиотеку
            // AnimateIcons(
            //   duration: const Duration(milliseconds: 500),
            //   controller: iconController,
            //   endIcon: Icons.arrow_upward,
            //   startIcon: Icons.arrow_downward,
            //   onStartIconPress: () {
            //     show == true;
            //     dropController.forward();
            //     setState(() {
            //       isVisible = !isVisible;
            //     });
            //     return true;
            //   },
            //   onEndIconPress: () {
            //     show == false;
            //     dropController.reverse();
            //     setState(() {
            //       isVisible = !isVisible;
            //     });
            //     return true;
            //   },
            // ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Card(
            child: ListTile(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Таким способом нет плавного появления',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 16))),
                    Text('Контейнер через Visibility',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18))),
                    Text('Стрелка через условие, как скидывала Оксана))',
                        style: GoogleFonts.aladin(
                            textStyle: const TextStyle(fontSize: 18)))
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

// Сердце из лекции лектория https://www.youtube.com/watch?v=w1FvTc1_bFQ  с 56 минуты про сердечко

class AnimatedHeard extends StatefulWidget {
  const AnimatedHeard({Key? key}) : super(key: key);

  @override
  State<AnimatedHeard> createState() => _AnimatedHeardState();
}

class _AnimatedHeardState extends State<AnimatedHeard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late final outerFade = Tween(begin: 1.0, end: 0.0).animate(controller);
  late final outerScale = Tween(begin: 1.0, end: 4.0).animate(controller);

  late final innerUpscale = CurvedAnimation(
    parent: controller,
    curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
  ).drive(Tween(begin: 1.0, end: 1.5));

  late final innerDowncale = CurvedAnimation(
    parent: controller,
    curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
  ).drive(Tween(begin: 1.0, end: 1.0 / 1.5));

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeTransition(
          opacity: outerFade,
          child: ScaleTransition(
            scale: outerScale,
            child: const Icon(
              Icons.favorite,
              size: 60,
              color: Colors.redAccent,
            ),
          ),
        ),
        ScaleTransition(
          scale: innerUpscale,
          child: ScaleTransition(
            scale: innerDowncale,
            child: const Icon(
              Icons.favorite,
              size: 60,
              color: Colors.redAccent,
            ),
          ),
        )
      ],
    );
  }
}
