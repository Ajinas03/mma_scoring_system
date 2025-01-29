import 'package:flutter/material.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/round/jury_round_screen.dart';
import 'package:my_app/screen/round/widgets/referee_info_widget.dart';
import 'package:my_app/utils/competetion_utils.dart';

import '../../models/competetion_model.dart';
import 'referee_round_screen.dart';
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
                    child: InkWell(
                      onTap: () {
                        SharedPrefsConfig.getString(
                                    SharedPrefsConfig.keyUserRole) ==
                                "jury"
                            ? pushScreen(
                                context,
                                JuryRoundScreen(
                                  eventId: competition?.eventId ?? "",
                                  position: getUserPosition(
                                        competition!,
                                        SharedPrefsConfig.getString(
                                          SharedPrefsConfig.keyUserId,
                                        ),
                                        SharedPrefsConfig.getString(
                                          SharedPrefsConfig.keyUserRole,
                                        ),
                                      ) ??
                                      "",
                                ),
                              )
                            : pushScreen(
                                context,
                                RefereeRoundScreen(
                                  position: getUserPosition(
                                        competition!,
                                        SharedPrefsConfig.getString(
                                          SharedPrefsConfig.keyUserId,
                                        ),
                                        SharedPrefsConfig.getString(
                                          SharedPrefsConfig.keyUserRole,
                                        ),
                                      ) ??
                                      "",
                                  eventId: competition?.eventId ?? "",
                                  refereeId: SharedPrefsConfig.getString(
                                      SharedPrefsConfig.keyUserId),
                                ));
                      },
                      child: RoundCard(
                        roundDetail: competition?.roundsDetails[index],
                        roundNumber: index + 1,
                      ),
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
