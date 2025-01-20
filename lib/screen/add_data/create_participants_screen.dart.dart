import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/logic/auth/auth_bloc.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';

import '../auth/widget/custom_indput_widget.dart';

class CreateParticipantScreen extends StatefulWidget {
  final String role;
  final String eventId;

  const CreateParticipantScreen({
    super.key,
    required this.role,
    required this.eventId,
  });

  @override
  State<CreateParticipantScreen> createState() =>
      _CreateParticipantScreenState();
}

class _CreateParticipantScreenState extends State<CreateParticipantScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'fname': '',
    'lname': '',
    'email': '',
    'phone': '',
    'role': '',
    'gender': '',
    'dob': null,
    'weight': 0,
    'city': '',
    'state': '',
    'country': '',
    'zipcode': '',
    'eventId': '',
  };

  bool get _isPlayerRole => widget.role == 'player';

  bool get _isFormValid {
    // Basic fields validation
    bool basicFieldsValid = [
      'fname',
      'lname',
      'email',
      'phone',
      'city',
      'state',
      'country',
      'zipcode',
    ].every((field) => _formData[field]?.toString().isNotEmpty ?? false);

    if (!basicFieldsValid) return false;

    // Additional validation for player role
    if (_isPlayerRole) {
      return _formData['gender']?.isNotEmpty == true &&
          _formData['dob'] != null &&
          (_formData['weight'] ?? 0) > 0;
    }

    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _formData['dob'] ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _formData['dob'] = picked;
      });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      print("create participant called");
      context.read<AuthBloc>().add(
            CreateParticipantEvent(
              fname: _formData['fname']!,
              lname: _formData['lname']!,
              email: _formData['email']!,
              phone: _formData['phone']!,
              role: _formData['role']!,
              dob: _isPlayerRole ? _formData['dob']! : DateTime.now(),
              gender: _isPlayerRole ? _formData['gender']! : '',
              weight: _isPlayerRole ? _formData['weight']! : 0,
              city: _formData['city']!,
              state: _formData['state']!,
              country: _formData['country']!,
              zipcode: _formData['zipcode']!,
              eventId: widget.eventId,
              context: context,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _formData['role'] = widget.role;
    _formData['eventId'] = widget.eventId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(title: "Create Participant"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomInputField(
                  label: 'First Name',
                  value: _formData['fname'],
                  onChanged: (value) =>
                      setState(() => _formData['fname'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter first name' : null,
                ),
                CustomInputField(
                  label: 'Last Name',
                  value: _formData['lname'],
                  onChanged: (value) =>
                      setState(() => _formData['lname'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter last name' : null,
                ),
                CustomInputField(
                  label: 'Email',
                  value: _formData['email'],
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      setState(() => _formData['email'] = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  label: 'Phone',
                  value: _formData['phone'],
                  keyboardType: TextInputType.phone,
                  onChanged: (value) =>
                      setState(() => _formData['phone'] = value),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter phone number'
                      : null,
                ),
                if (_isPlayerRole) ...[
                  CustomInputField(
                    label: 'Gender',
                    value: _formData['gender'],
                    onChanged: (value) =>
                        setState(() => _formData['gender'] = value),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter gender' : null,
                  ),

                  // Date of Birth Picker
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formData['dob'] == null
                                ? 'Select Date of Birth'
                                : DateFormat('MMM dd, yyyy')
                                    .format(_formData['dob']),
                            style: TextStyle(
                              color: _formData['dob'] == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),

                  CustomInputField(
                    label: 'Weight (kg)',
                    value: _formData['weight'].toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() =>
                        _formData['weight'] = double.tryParse(value) ?? 0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter weight';
                      }
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                  ),
                ],
                CustomInputField(
                  label: 'City',
                  value: _formData['city'],
                  onChanged: (value) =>
                      setState(() => _formData['city'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter city' : null,
                ),
                CustomInputField(
                  label: 'State',
                  value: _formData['state'],
                  onChanged: (value) =>
                      setState(() => _formData['state'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter state' : null,
                ),
                CustomInputField(
                  label: 'Country',
                  value: _formData['country'],
                  onChanged: (value) =>
                      setState(() => _formData['country'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter country' : null,
                ),
                CustomInputField(
                  label: 'Zipcode',
                  value: _formData['zipcode'],
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      setState(() => _formData['zipcode'] = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter zipcode' : null,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? const Align(child: CircularProgressIndicator())
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.signUpError != null) ...[
                                TextWidget(
                                  text: state.signUpError!,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 10),
                              ],
                              ElevatedButton(
                                onPressed: _isFormValid ? _onSubmit : null,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Create Participant'),
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
