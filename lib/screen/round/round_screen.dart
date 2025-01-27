// lib/screens/round_screen/round_screen.dart
import 'package:flutter/material.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/round/widgets/referee_info_widget.dart';

import '../../models/competetion_model.dart';
import 'widgets/player_info_card.dart';
import 'widgets/round_card.dart';

class RoundScreen extends StatelessWidget {
  final CompetetionModel? competition;

  const RoundScreen({super.key, required this.competition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(title: "Competition Rounds"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: PlayerInfoCard(
                      player: competition?.redCornerPlayer,
                      cornerColor: Colors.red,
                      isRedCorner: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PlayerInfoCard(
                      player: competition?.blueCornerPlayer,
                      cornerColor: Colors.blue,
                      isRedCorner: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              RefereeInfoWidget(
                cornerAReferee: competition?.cornerAReferee,
                cornerBReferee: competition?.cornerBReferee,
                cornerCReferee: competition?.cornerCReferee,
              ),
              const SizedBox(height: 24),
              Text(
                'Rounds',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: competition?.roundsDetails.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RoundCard(
                      roundDetail: competition?.roundsDetails[index],
                      roundNumber: index + 1,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
