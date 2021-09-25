import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

var isPaused = true.obs;
var timerDuration = 600.obs;
bool isStarted = false;

class TimerBody extends StatefulWidget {
  TimerBody({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerBody> createState() => _TimerBodyState();
}

class _TimerBodyState extends State<TimerBody> with AutomaticKeepAliveClientMixin {
  final controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          child: Obx(
            () => CircularCountDownTimer(
              duration: timerDuration.value,
              initialDuration: 0,
              controller: controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey.shade100,
              fillColor: Colors.purpleAccent.shade400,
              fillGradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.blue,
                ],
              ),
              backgroundGradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.blue,
                ],
              ),
              strokeWidth: 5.0,
              strokeCap: StrokeCap.square,
              textStyle: TextStyle(fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: false,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: false,
              onStart: () {
                print('Countdown Started');
              },
              onComplete: () {
                isPaused.value = false;
                print('Countdown Ended');
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => AnimatedSwitcher(
                duration: Duration(microseconds: 100),
                child: isPaused.value
                    ? FloatingActionButton(
                        onPressed: () {
                          if (isStarted) {
                            isStarted = true;
                            controller.start();
                          } else {
                            controller.resume();
                          }
                          isPaused.value = false;
                        },
                        child: Icon(
                          Icons.play_arrow,
                        ),
                      )
                    : FloatingActionButton(
                        onPressed: () {
                          controller.pause();
                          isPaused.value = true;
                        },
                        child: Icon(
                          Icons.pause,
                        ),
                      ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => mounted;
}
