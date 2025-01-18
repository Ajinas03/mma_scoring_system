import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/screen/common/text_widget.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  int elapsedTime = 0; // To track the elapsed time

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startTimer() {
    elapsedTime = 0;

    if (timer != null && timer!.isActive) return; // Avoid multiple timers
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsedTime++;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      timer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: IconButton(
            onPressed: () {
              if (timer == null) {
                startTimer();
              } else {
                stopTimer();
              }
            },
            icon: Icon(timer != null ? Icons.stop : Icons.play_arrow_rounded)),
      ),
      title: TextWidget(text: "Seconds : $elapsedTime"),
    );
  }
}
