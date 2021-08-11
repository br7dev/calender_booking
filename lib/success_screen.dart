import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'calendar_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 1000);
  late Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation,
      _muchDelayedAnimationSize,
      _delayedAnimationRadius;
  late AnimationController _containerAnimationController;

  @override
  void initState() {
    super.initState();
    _containerAnimationController =
        AnimationController(vsync: this, duration: _duration);

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            curve: Curves.linearToEaseOut,
            parent: _containerAnimationController));

    _containerSizeAnimation = Tween(begin: 0.0, end: 5.0).animate(
        CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerColorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.blueAccent).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));

    _delayedAnimationRadius = BorderRadiusTween(
            begin: BorderRadius.circular(50.0),
            end: BorderRadius.circular(100.0))
        .animate(CurvedAnimation(
            curve: Curves.decelerate, parent: _containerAnimationController));

    _muchDelayedAnimationSize = Tween(begin: 2.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _containerAnimationController,
            curve: Interval(0.2, 0.6, curve: Curves.easeIn)));
    _containerAnimationController.forward();
  }

  @override
  void dispose() {
    _containerAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SuccessScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _containerAnimationController.duration = _duration;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _containerAnimationController,
        builder: (context, index) {
          return Stack(
            children: [
              Center(
                child: Container(
                  width: _containerSizeAnimation.value * height,
                  height: _containerSizeAnimation.value * height,
                  decoration: BoxDecoration(
                      borderRadius: _containerRadiusAnimation.value,
                      color: _containerColorAnimation.value),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: _containerSizeAnimation.value * height * 0.02,
                        height: _containerSizeAnimation.value * height * 0.02,
                        decoration: BoxDecoration(
                          borderRadius: _delayedAnimationRadius.value,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your slots have been booked',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Calendar()),
                            );
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
