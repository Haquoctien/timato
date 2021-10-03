import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/todo_checkbox.dart';
import 'package:timato/widgets/todo_details.dart';
import '../../widgets/count_down_timer.dart';
import 'duration_picker.dart';

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

class _TimerScreenState extends State<TimerScreen> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final controller = CountDownController();
  bool _isPaused = false;
  bool _isStarted = false;
  bool _isComplete = false;
  bool get _isReset => !(_isPaused || _isComplete || _isStarted) && _duration > 0;
  int _duration = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var stackHeight = widget.todo == null ? screenHeight : screenHeight * 0.7;

    var timerWidth = 200.0;
    var buttonsWidth = 50;
    var buttonsPadding = 20;

    var timerTop = stackHeight * 0.4;
    var timerLeft = (screenWidth - timerWidth) / 2;
    var playTop = timerTop + timerWidth + buttonsPadding;
    var playLeft = (screenWidth - (_isStarted || _isComplete ? (buttonsWidth * 2 + buttonsPadding) : buttonsWidth)) / 2;
    var resetTop = playTop;
    var resetLeft = (screenWidth + buttonsPadding) / 2;

    var scheme = Theme.of(context).colorScheme;
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
                        icon: Icon(Icons.arrow_back, color: scheme.primary),
                      ),
                    ),
                    Positioned(
                      top: timerTop,
                      left: timerLeft,
                      child: InkWell(
                        onTap: () {
                          if (_isComplete || !_isStarted) setTimer(context);
                        },
                        child: CountDownProgressIndicator(
                          size: timerWidth,
                          controller: controller,
                          valueColor: scheme.secondary,
                          backgroundColor: scheme.primary,
                          initialPosition: 0,
                          strokeWidth: 5,
                          duration: _duration,
                          timeFormatter: (seconds) => Duration(seconds: seconds).format(),
                          onComplete: () {
                            complete();
                          },
                          autostart: false,
                          text: "hh:mm:ss",
                          timeTextStyle: TextStyle(
                            color: scheme.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          labelTextStyle: TextStyle(
                            color: scheme.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      top: playTop,
                      left: playLeft,
                      child: FloatingActionButton(
                        key: Key("AnimatedIcon"),
                        backgroundColor: scheme.primary,
                        onPressed: () {
                          if (_isReset) {
                            start();
                            return;
                          }

                          if (_isComplete || !_isStarted) {
                            setTimer(context, autoStart: true);
                            return;
                          }

                          if (_isStarted) {
                            if (_isPaused) {
                              resume();
                            } else {
                              pause();
                            }
                            return;
                          }

                          start();
                        },
                        child: AnimatedIcon(
                          progress: _animationController,
                          icon: AnimatedIcons.play_pause,
                          color: scheme.secondary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: resetTop,
                      left: resetLeft,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: _isStarted || _isComplete
                            ? FloatingActionButton(
                                backgroundColor: scheme.primary,
                                onPressed: () {
                                  reset();
                                },
                                child: Icon(
                                  Icons.restart_alt_sharp,
                                  color: scheme.secondary,
                                ),
                              )
                            : Container(),
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

  void setTimer(BuildContext context, {autoStart: false}) {
    showCupertinoDialog<Duration>(
      context: context,
      builder: (context) => DurationPicker(),
    ).then((value) {
      if (value != null && value.inSeconds > 0) {
        setState(() {
          _duration = value.inSeconds;
        });
        if (autoStart) {
          start();
        }
      }
    });
  }

  void reset() {
    setState(() {
      _isComplete = false;
      _isStarted = false;
      _isPaused = false;
    });
    controller.reset();
    _animationController.reverse();
  }

  void start() {
    setState(() {
      _isComplete = false;
      _isStarted = true;
      _isPaused = false;
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.start();
      _animationController.forward();
    });
  }

  void resume() {
    setState(() {
      _isComplete = false;
      _isPaused = false;
      _isStarted = true;
    });
    controller.resume();
    _animationController.forward();
  }

  void pause() {
    setState(() {
      _isComplete = false;
      _isPaused = true;
      _isStarted = true;
    });
    controller.pause();
    _animationController.reverse();
  }

  void complete() {
    setState(() {
      _isComplete = true;
      _isPaused = false;
      _isStarted = false;
    });
    _animationController.reverse();
  }

  @override
  bool get wantKeepAlive => mounted;
}

extension on Duration {
  format() => this.toString().split('.').first.padLeft(8, "0");
}
