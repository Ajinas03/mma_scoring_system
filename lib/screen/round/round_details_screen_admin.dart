import 'package:flutter/material.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/round/round_widgets/fade_animated_list_view.dart';
import 'package:my_app/screen/round/round_widgets/timer_widget.dart';

class RoundDetailsScreenAdmin extends StatelessWidget {
  const RoundDetailsScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(title: "Event Name  (Admin) "),
      body: Column(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: "Score",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: "10",
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const TimerWidget(),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 1"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 2"),
                  ),
                )
              ],
            ),
          ),
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: AnimatedListView()),
                // Expanded(
                //   child: ScoreSection(
                //     hero: "sd",
                //     bgColor: Colors.red,
                //   ),
                // ),
                Expanded(child: AnimatedListView()),
                // Expanded(
                //   child: ScoreSection(
                //     hero: "hg",
                //     bgColor: Colors.blue,
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
