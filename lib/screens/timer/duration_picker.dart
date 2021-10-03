import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timato/screens/timer/wheel_picker.dart';

class DurationPicker extends StatelessWidget {
  const DurationPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minute = 0;
    int second = 0;
    int hour = 0;
    double width = 80;
    double height = 100;
    double zoom = 1;
    return AlertDialog(
      title: Text("Pick a duration:"),
      contentPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.center,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  height: height,
                  width: width,
                  child: WheelChooser.integer(
                    onValueChanged: (i) => hour = i,
                    maxValue: 23,
                    minValue: 0,
                    initValue: 0,
                    isInfinite: true,
                    magnification: zoom,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "hh",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  height: height,
                  width: width,
                  child: WheelChooser.integer(
                    onValueChanged: (i) => minute = i,
                    maxValue: 59,
                    minValue: 0,
                    initValue: 0,
                    isInfinite: true,
                    magnification: zoom,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "mm",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  height: height,
                  width: width,
                  child: WheelChooser.integer(
                    onValueChanged: (i) => second = i,
                    maxValue: 59,
                    minValue: 0,
                    initValue: 0,
                    isInfinite: true,
                    magnification: zoom,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "ss",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(
              result: Duration(seconds: hour * 3600 + minute * 60 + second),
            );
          },
          child: Text(
            "Confirm",
          ),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
          ),
        )
      ],
    );
  }
}
