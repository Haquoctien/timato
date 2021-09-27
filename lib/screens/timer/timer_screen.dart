import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/todo_checkbox.dart';
import 'package:timato/widgets/todo_details.dart';

import '../../widgets/count_down_timer.dart';

bool isStarted = false;

class TimerScreen extends StatefulWidget {
  final Todo? todo;
  final VoidCallback close;
  TimerScreen({
    Key? key,
    this.todo,
    required this.close,
  }) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with AutomaticKeepAliveClientMixin {
  final controller = CountDownController();
  bool _isPaused = true;

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var stackHeight = widget.todo == null ? screenHeight : screenHeight * 0.7;
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        widget.close();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: stackHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                          ],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.xor,
                      child: Image.asset(
                        "assets/images/working_male.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        iconSize: 40,
                        onPressed: Get.back,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ),
                    Positioned(
                      top: stackHeight * 0.4,
                      left: (screenWidth - 200) / 2,
                      child: CountDownProgressIndicator(
                        size: 200,
                        controller: controller,
                        valueColor: Colors.blue,
                        backgroundColor: Colors.lightGreen.shade300,
                        initialPosition: 0,
                        duration: 10,
                        timeFormatter: (seconds) => Duration(seconds: seconds).format(),
                        onComplete: () => null,
                        autostart: false,
                        text: "hh:mm:ss",
                      ),
                    ),
                    Positioned(
                      top: stackHeight * 0.4 + 250,
                      left: (MediaQuery.of(context).size.width - 50) / 2,
                      child: AnimatedSwitcher(
                        duration: Duration(microseconds: 100),
                        child: _isPaused
                            ? FloatingActionButton(
                                // TODO
                                //backgroundColor: Colors.lightGreen,
                                onPressed: () {
                                  if (isStarted) {
                                    isStarted = true;
                                    controller.start();
                                  } else {
                                    controller.resume();
                                  }
                                  setState(() {
                                    _isPaused = false;
                                  });
                                },
                                child: Icon(
                                  Icons.play_arrow,
                                ),
                              )
                            : FloatingActionButton(
                                // TODO
                                //backgroundColor: Colors.lightGreen,
                                onPressed: () {
                                  controller.pause();
                                  setState(() {
                                    _isPaused = true;
                                  });
                                },
                                child: Icon(
                                  Icons.pause,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.todo != null)
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, bottom: 10, top: 0, right: 8),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            TodoCheckBox(),
                          ],
                        ),
                      ),
                      TodoDetails(todo: widget.todo!),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => mounted;
}

extension on Duration {
  format() => this.toString().split('.').first.padLeft(8, "0");
}
