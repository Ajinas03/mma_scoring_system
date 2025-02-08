import 'package:flutter/material.dart';

import 'retro_game_button.dart';

class GameBoyStyleControls extends StatelessWidget {
  final VoidCallback onBlueLeftPressed;
  final VoidCallback onBlueRightPressed;
  final VoidCallback onRedLeftPressed;
  final VoidCallback onRedRightPressed;
  final double buttonSize;

  const GameBoyStyleControls({
    super.key,
    required this.onBlueLeftPressed,
    required this.onBlueRightPressed,
    required this.onRedLeftPressed,
    required this.onRedRightPressed,
    this.buttonSize = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          // Blue side
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left button (higher)
                  Transform.translate(
                    offset: Offset(0, -buttonSize * 0.3),
                    child: RetroGameButton(
                      onPressed: onBlueLeftPressed,
                      icon: Icons.remove,
                      buttonColor: Colors.blue.shade700,
                      size: buttonSize,
                    ),
                  ),
                  SizedBox(width: buttonSize * 0.4),
                  // Right button (lower)
                  RetroGameButton(
                    onPressed: onBlueRightPressed,
                    icon: Icons.add,
                    buttonColor: Colors.blue.shade900,
                    size: buttonSize,
                  ),
                ],
              ),
            ),
          ),
          // Divider line
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Container(
              width: 0.2,
              color: Colors.grey.shade800,
              height: double.infinity,
            ),
          ),
          // Red side
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left button (lower)
                  RetroGameButton(
                    onPressed: onRedLeftPressed,
                    icon: Icons.add,
                    buttonColor: Colors.red.shade900,
                    size: buttonSize,
                  ),
                  SizedBox(width: buttonSize * 0.4),
                  // Right button (higher)
                  Transform.translate(
                    offset: Offset(0, -buttonSize * 0.3),
                    child: RetroGameButton(
                      onPressed: onRedRightPressed,
                      icon: Icons.remove,
                      buttonColor: Colors.red.shade700,
                      size: buttonSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
