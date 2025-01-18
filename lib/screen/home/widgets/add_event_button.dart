import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import 'add_event_dialog.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddEventDialog(context),
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddEventDialog(),
    );
  }
}
