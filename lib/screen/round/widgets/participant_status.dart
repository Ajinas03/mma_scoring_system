import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/connection/connection_bloc.dart' as ct;
import 'package:my_app/screen/common/text_widget.dart';

import '../../../logic/match/match_bloc.dart';

class ParticipantStatus extends StatelessWidget {
  const ParticipantStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        return BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
          builder: (context, ctState) {
            return Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Info Message \n${ctState.infoMessage}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          textAlign: TextAlign.start,
                          text: 'Connection Status   :',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        // if (state.connectedReferees.length == 3 &&
                        //     state.isJuryConnected)

                        if (ctState.status == ct.ConnectionStatus.connecting)
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (ctState.status ==
                            ct.ConnectionStatus.connected)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 32,
                          )
                        else
                          const Icon(
                            Icons.warning,
                            color: Colors.orange,
                            size: 32,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
