import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/round/round_widgets/score_button.dart';

import '../../../logic/socket/socket_bloc.dart';

class ScoreSection extends StatelessWidget {
  final String hero;
  final Color bgColor;
  const ScoreSection({super.key, required this.bgColor, required this.hero});

  @override
  Widget build(BuildContext context) {
    final socketBloc = BlocProvider.of<SocketBloc>(context);

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView.separated(
            separatorBuilder: (ctx, idx) => const SizedBox(
                  height: 10,
                ),
            itemCount: 3,
            itemBuilder: (context, index) {
              final score = index + 1 * 5;
              return ScoreButton(
                title: "+ $score",
                onTap: () {
                  socketBloc.add(SendMessage(message: "Score Updated  $score"));
                  print("tapped scoreee... ");
                },
                heroTag: "p + ${index.toString()} + $hero",
              );
            }),
      ),
    );
  }
}
