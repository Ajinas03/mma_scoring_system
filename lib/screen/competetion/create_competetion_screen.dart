import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/event/event_bloc.dart';
import '../../models/get_participants_model.dart';
import 'competetion_widgets/custom_dropdown_widget.dart';

class CreateCompetitionScreen extends StatefulWidget {
  const CreateCompetitionScreen({super.key});

  @override
  State<CreateCompetitionScreen> createState() =>
      _CreateCompetitionScreenState();
}

class _CreateCompetitionScreenState extends State<CreateCompetitionScreen> {
  String? redCornerPlayerId;
  String? blueCornerPlayerId;
  String? cornerARefereeId;
  String? cornerBRefereeId;
  String? cornerCRefereeId;

  String? redCornerPlayerName;
  String? blueCornerPlayerName;
  String? cornerARefereeName;
  String? cornerBRefereeName;
  String? cornerCRefereeName;
  String? errorMessage;

  bool validateForm() {
    if (redCornerPlayerId == null || blueCornerPlayerId == null) {
      setState(() => errorMessage = 'Please select both players');
      return false;
    }
    if (redCornerPlayerId == blueCornerPlayerId) {
      setState(() => errorMessage = 'Players must be different');
      return false;
    }
    if (cornerARefereeId == null ||
        cornerBRefereeId == null ||
        cornerCRefereeId == null) {
      setState(() => errorMessage = 'Please select all referees');
      return false;
    }
    return true;
  }

  void createCompetition(String eventId) {
    if (!validateForm()) return;

    final competition = {
      'eventId': eventId,
      'redCornerPlayerId': redCornerPlayerId,
      'blueCornerPlayerId': blueCornerPlayerId,
      'CornerARefereeId': cornerARefereeId,
      'CornerBRefereeId': cornerBRefereeId,
      'CornerCRefereeId': cornerCRefereeId,
    };

    context.read<EventBloc>().add(CreateCompetetionEvent(
          context: context,
          eventId: eventId,
          redCornerPlayerId: redCornerPlayerId ?? "",
          blueCornerPlayerId: blueCornerPlayerId ?? "",
          cornerARefereeId: cornerARefereeId ?? "",
          cornerBRefereeId: cornerBRefereeId ?? "",
          cornerCRefereeId: cornerCRefereeId ?? "",
          blueCornerPlayerName: blueCornerPlayerName ?? "",
          cornerBRefereeName: cornerBRefereeName ?? "",
          cornerCRefereeName: cornerCRefereeName ?? "",
          redCornerPlayerName: redCornerPlayerName ?? "",
          cornerARefereeName: cornerARefereeName ?? "",
        ));

    // TODO: Send competition data to your API
    print('Competition created: $competition');
  }

  String _getUsername(Jury jury) {
    return jury.username;
  }

  String? _getUsernameById(List<Jury> juryList, String? id) {
    if (id == null) return null;
    final jury = juryList.firstWhere(
      (jury) => jury.userId == id,
      orElse: () => Jury(
        phone: '',
        fname: '',
        lname: '',
        username: '',
        userId: '',
        eventId: '',
        role: '',
        city: '',
        state: '',
        country: '',
        email: '',
        dob: DateTime.now(),
        gender: '',
        weight: 0,
        zipcode: '',
      ),
    );
    return _getUsername(jury);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Competition'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            final GetParicipantsModel participants =
                state.getParicipantsModel ??
                    GetParicipantsModel(
                      eventId: "eventId",
                      players: [],
                      jury: [],
                      referees: [],
                    );
            final playerUsernames =
                participants.players.map(_getUsername).toList();
            final refereeUsernames =
                participants.referees.map(_getUsername).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Players Selection with VS
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Red Corner',
                        items: playerUsernames,
                        value: _getUsernameById(
                            participants.players, redCornerPlayerId),
                        onChanged: (value) => setState(() {
                          if (value != null) {
                            final player = participants.players.firstWhere(
                              (p) => _getUsername(p) == value,
                            );
                            redCornerPlayerId = player.userId;
                            redCornerPlayerName = player.username;
                          }
                          errorMessage = null;
                        }),
                        labelColor: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'VS',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    Expanded(
                      child: CustomDropdown(
                        label: 'Blue Corner',
                        items: playerUsernames,
                        value: _getUsernameById(
                            participants.players, blueCornerPlayerId),
                        onChanged: (value) => setState(() {
                          if (value != null) {
                            final player = participants.players.firstWhere(
                              (p) => _getUsername(p) == value,
                            );
                            blueCornerPlayerId = player.userId;
                            blueCornerPlayerName = player.username;
                          }
                          errorMessage = null;
                        }),
                        labelColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                CustomDropdown(
                  label: 'Corner A Referee',
                  items: refereeUsernames,
                  value:
                      _getUsernameById(participants.referees, cornerARefereeId),
                  onChanged: (value) => setState(() {
                    if (value != null) {
                      final referee = participants.referees.firstWhere(
                        (r) => _getUsername(r) == value,
                      );
                      cornerARefereeId = referee.userId;
                      cornerARefereeName = referee.username;
                    }
                    errorMessage = null;
                  }),
                ),
                const SizedBox(height: 20),

                CustomDropdown(
                  label: 'Corner B Referee',
                  items: refereeUsernames,
                  value:
                      _getUsernameById(participants.referees, cornerBRefereeId),
                  onChanged: (value) => setState(() {
                    if (value != null) {
                      final referee = participants.referees.firstWhere(
                        (r) => _getUsername(r) == value,
                      );
                      cornerBRefereeId = referee.userId;
                      cornerBRefereeName = referee.username;
                    }
                    errorMessage = null;
                  }),
                ),
                const SizedBox(height: 20),

                CustomDropdown(
                  label: 'Corner C Referee',
                  items: refereeUsernames,
                  value:
                      _getUsernameById(participants.referees, cornerCRefereeId),
                  onChanged: (value) => setState(() {
                    if (value != null) {
                      final referee = participants.referees.firstWhere(
                        (r) => _getUsername(r) == value,
                      );
                      cornerCRefereeId = referee.userId;
                      cornerCRefereeName = referee.username;
                    }
                    errorMessage = null;
                  }),
                ),
                const SizedBox(height: 20),

                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ElevatedButton(
                  onPressed: () => createCompetition(participants.eventId),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Competition',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
