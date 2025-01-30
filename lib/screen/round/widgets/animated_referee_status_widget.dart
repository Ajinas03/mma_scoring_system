import 'package:flutter/material.dart';
import 'package:my_app/screen/round/widgets/timer_display.dart';

import '../../../models/connected_user_model.dart';

class RefereeStatusWidget extends StatefulWidget {
  final ConnectedUserModel? model;

  const RefereeStatusWidget({
    super.key,
    required this.model,
  });

  @override
  State<RefereeStatusWidget> createState() => _RefereeStatusWidgetState();
}

class _RefereeStatusWidgetState extends State<RefereeStatusWidget> {
  // Track previous connection states to detect changes
  final Map<String, bool> _previousStates = {};

  Widget _buildStatusIndicator(String title, bool isConnected) {
    // Check if connection state changed
    bool isNewConnection = _previousStates[title] == false && isConnected;
    _previousStates[title] = isConnected;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(
        begin: isNewConnection ? 0.0 : 1.0,
        end: 1.0,
      ),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0), // Slide from left
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2 * value),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween<double>(
                      begin: 0.0,
                      end: isConnected ? 1.0 : 0.0,
                    ),
                    builder: (context, value, child) {
                      return Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(Colors.grey, Colors.green, value),
                          boxShadow: [
                            BoxShadow(
                              color: (isConnected ? Colors.green : Colors.grey)
                                  .withOpacity(0.3 * value),
                              spreadRadius: 2 * value,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusIndicator(
                'Main Jury',
                widget.model?.details.mainJury.isConnected ?? false,
              ),
              _buildStatusIndicator(
                'Corner A',
                widget.model?.details.cornerAReferee.isConnected ?? false,
              ),
            ],
          ),
          TimerDisplay(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusIndicator(
                'Corner B',
                widget.model?.details.cornerBReferee.isConnected ?? false,
              ),
              const SizedBox(width: 8),
              _buildStatusIndicator(
                'Corner C',
                widget.model?.details.cornerCReferee.isConnected ?? false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _areAllConnected() {
    return (widget.model?.details.mainJury.isConnected ?? false) &&
        (widget.model?.details.cornerAReferee.isConnected ?? false) &&
        (widget.model?.details.cornerBReferee.isConnected ?? false) &&
        (widget.model?.details.cornerCReferee.isConnected ?? false);
  }

  String _getStatusMessage() {
    if (_areAllConnected()) {
      return 'All referees connected successfully';
    }
    return 'Waiting for all referees to connect...';
  }
}
