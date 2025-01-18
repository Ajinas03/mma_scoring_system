import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _redCornerController = TextEditingController();
  final _blueCornerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Event'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter event title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),
              _buildParticipantFields(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(

              // primary: AppColors.primary

              ),
          child: const Text('Add Event'),
        ),
      ],
    );
  }

  Widget _buildParticipantFields() {
    return Column(
      children: [
        TextFormField(
          controller: _redCornerController,
          decoration: const InputDecoration(
            labelText: 'Red Corner Fighter',
            prefixIcon: Icon(Icons.person, color: AppColors.redCorner),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter red corner fighter' : null,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _blueCornerController,
          decoration: const InputDecoration(
            labelText: 'Blue Corner Fighter',
            prefixIcon: Icon(Icons.person, color: AppColors.blueCorner),
          ),
          validator: (value) => value?.isEmpty ?? true
              ? 'Please enter blue corner fighter'
              : null,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement event creation logic
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _redCornerController.dispose();
    _blueCornerController.dispose();
    super.dispose();
  }
}
