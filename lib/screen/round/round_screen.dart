import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/round/jury_round_screen.dart';
import 'package:my_app/screen/round/widgets/referee_info_widget.dart';
import 'package:my_app/utils/competetion_utils.dart';

import '../../logic/event/event_bloc.dart';
import '../../models/competetion_model.dart';
import 'referee_round_screen.dart';
import 'widgets/player_info_card.dart';
import 'widgets/round_card.dart';

class RoundScreen extends StatefulWidget {
  final String eventId;
  final int index;
  // final CompetetionModel? competition;

  const RoundScreen(
      {super.key,
      required this.index,

      //  required this.competition,
      required this.eventId});

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> with WidgetsBindingObserver {
  bool isRoundSelectable(List<RoundsDetail> rounds, int currentIndex) {
    if (currentIndex == 0) return true;
    return rounds[currentIndex - 1].status == 2;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _handleScreenPop(BuildContext context) async {
    // Refresh competition data or perform any necessary updates
    context.read<EventBloc>().add(GetCompetetion(eventId: widget.eventId));
  }

  Future<void> _navigateToRound(BuildContext context, Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

    if (result == true) {
      await _handleScreenPop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _handleScreenPop(context);
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<EventBloc, EventState>(
          builder: (context, evState) {
            return 
            
            
            
            
            
            
            FloatingActionButton.extended(
                onPressed: () {}, label: Text("Take Descision"));
          },
        ),
        appBar: secondaryAppBar(
          title: "Competition Rounds",
          // onLeading: () async {
          //   await _handleScreenPop(context);
          //   Navigator.pop(context);
          // },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                final competition = state.competetionModel?[widget.index];
                return state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
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
                            itemCount: competition?.roundsDetails.length ?? 0,
                            itemBuilder: (context, index) {
                              final isEnabled = isRoundSelectable(
                                competition?.roundsDetails ?? [],
                                index,
                              );

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: InkWell(
                                  onTap: isEnabled
                                      ? () async {
                                          final userRole =
                                              SharedPrefsConfig.getString(
                                            SharedPrefsConfig.keyUserRole,
                                          );
                                          final userId =
                                              SharedPrefsConfig.getString(
                                            SharedPrefsConfig.keyUserId,
                                          );
                                          final position = getUserPosition(
                                                competition!,
                                                userId,
                                                userRole,
                                              ) ??
                                              "";

                                          if (competition.roundsDetails[index]
                                                  .status ==
                                              2) {
                                            context.read<EventBloc>().add(
                                                GetRoundAnalytics(
                                                    isFromMark: false,
                                                    eventId: widget.eventId,
                                                    competitionId:
                                                        competition.id,
                                                    position:
                                                        position == "mainJury"
                                                            ? "all"
                                                            : position,
                                                    round: index + 1,
                                                    context: context));

                                            // await _navigateToRound(
                                            //   context,
                                            //   RoundAnalyticsDisplay(),
                                            // );
                                          } else {
                                            if (userRole == "jury") {
                                              await _navigateToRound(
                                                context,
                                                JuryRoundScreen(
                                                  eventId: widget.eventId,
                                                  round: index + 1,
                                                  competitionId: competition.id,
                                                  position: position,
                                                ),
                                              );
                                            } else {
                                              await _navigateToRound(
                                                context,
                                                RefereeRoundScreen(
                                                  eventId: widget.eventId,
                                                  position: position,
                                                  competitionId: competition.id,
                                                  refereeId: userId,
                                                  round: index + 1,
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      : null,
                                  child: RoundCard(
                                    roundDetail:
                                        competition?.roundsDetails[index],
                                    roundNumber: index + 1,
                                    isEnabled: isEnabled,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
