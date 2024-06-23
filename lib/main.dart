import 'package:animated_nav_rive/model/nav_item_model.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BeforeHome(),
    );
  }
}

class BeforeHome extends StatefulWidget {
  const BeforeHome({super.key});

  @override
  State<BeforeHome> createState() => _BeforeHomeState();
}

class _BeforeHomeState extends State<BeforeHome> {
  final Color nav_bg = Color(0xFF17203A);

  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  List<String> pages = [
    'Messages',
    'Search',
    'Notification',
    'History',
    'Profile'
  ];
  int currentNavItem = 0;

  void clickNavItem(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(
      Duration(seconds: 1),
      () => riveIconInputs[index].change(false),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // checkVibrator();
    super.initState();
  }

  void checkVibrator() async {
    if (await Vibration.hasVibrator() != null) {
      Vibration.vibrate();
    } else {
      print('no vibrator');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(pages[currentNavItem]),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 24),
          decoration: BoxDecoration(
            color: nav_bg.withOpacity(0.8),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: nav_bg.withOpacity(0.3),
                  offset: Offset(0, 20),
                  blurRadius: 20),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(bottomNavItem.length, (index) {
              final riveItem = bottomNavItem[index].rive;

              return GestureDetector(
                onTap: () async {
                  clickNavItem(index);
                  // if (await Vibration.hasVibrator() != null) {
                  //   Vibration.vibrate();
                  // } else {
                  //   print('no vibrator');
                  // }
                  if (await Vibration.hasAmplitudeControl() != null) {
                    Vibration.vibrate(amplitude: 90);
                  }
                  setState(() {
                    currentNavItem = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimateBar(
                      isActive: currentNavItem == index,
                    ),
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: Opacity(
                        opacity: currentNavItem == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveItem.src,
                          artboard: riveItem.artBoard,
                          onInit: (artboard) {
                            StateMachineController? controller =
                                StateMachineController.fromArtboard(
                                    artboard, riveItem.stateMachineName);

                            artboard.addController(controller!);
                            controllers.add(controller);

                            riveIconInputs.add(controller
                                .findInput<bool>('active') as SMIBool);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AnimateBar extends StatelessWidget {
  final bool isActive;
  const AnimateBar({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 5),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
          color: Color(0xff81b4ff), borderRadius: BorderRadius.circular(5)),
    );
  }
}
