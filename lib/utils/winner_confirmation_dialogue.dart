import 'package:flutter/material.dart';

class WinnerConfirmationDialog extends StatefulWidget {
  final Function(String) onConfirm;
  final String playerName; // Add player name parameter

  const WinnerConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.playerName, // Make playerName required
  });

  @override
  State<WinnerConfirmationDialog> createState() =>
      _WinnerConfirmationDialogState();
}

class _WinnerConfirmationDialogState extends State<WinnerConfirmationDialog> {
  String? selectedOption;
  final List<String> winOptions = [
    'P',
    'KO/KD',
    'DISQ',
    'RSC',
    'RSCH',
    'W.O',
    'AB',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you really sure about making ${widget.playerName} as winner?',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select WON by:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: winOptions.map((option) {
            return RadioListTile<String>(
              contentPadding: EdgeInsets.all(0),
              title: Text(option),
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedOption == null
              ? null
              : () {
                  widget.onConfirm(selectedOption!);
                  Navigator.of(context).pop();
                },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
