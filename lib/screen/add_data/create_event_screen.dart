// create_event_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';
import 'package:my_app/models/create_event_model.dart';
import 'package:my_app/screen/auth/widget/custom_dropdown_widget.dart';

import '../common/city_search_dropdown.dart';

class CreateRoundScreen extends StatefulWidget {
  const CreateRoundScreen({super.key});

  @override
  State<CreateRoundScreen> createState() => _CreateRoundScreenState();
}

class _CreateRoundScreenState extends State<CreateRoundScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipcodeController = TextEditingController();
  DateTime? _selectedDate;

  bool get isFormValid {
    return _nameController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _countryController.text.isNotEmpty &&
        _zipcodeController.text.isNotEmpty &&
        _selectedDate != null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final catergories = ["Kick Boxing"];

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final eventData = {
        'name': _nameController.text,
        'category': _categoryController.text,
        'date': _selectedDate!.toIso8601String(),
        'city': _cityController.text,
        'address': _addressController.text,
        'state': _stateController.text,
        'country': _countryController.text,
        'zipcode': _zipcodeController.text,
      };

      context.read<EventBloc>().add(CreateEvent(
          context: context,
          createEventRequest: CreateEventRequest(
            role: SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole),
            name: _nameController.text,
            category: _categoryController.text,
            date: _selectedDate ?? DateTime.now(),
            city: _cityController.text,
            address: _addressController.text,
            state: _stateController.text,
            country: _countryController.text,
            zipcode: _zipcodeController.text,
          )));

      // TODO: Handle the event data submission
      print(eventData); // Replace with actual API call
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _categoryController.text = catergories[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: () =>
              setState(() {}), // Trigger rebuild to update submit button
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Event Name',
                hint: 'Enter event name',
              ),
              const SizedBox(height: 16),
              // _buildTextField(
              //   controller: _categoryController,
              //   label: 'Category',
              //   hint: 'Enter event category',
              // ),
              CustomDropdown(
                label: 'Select Category',
                value: _categoryController.text,
                items: catergories,
                onChanged: (value) =>
                    setState(() => _categoryController.text = value ?? ''),
              ),

              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 16),
              CitySearchDropdown(
                onCitySelected: (selectedCity) {
                  // Handle selected city, e.g., save to state or navigate
                  print(
                      'Selected: ${selectedCity.city}, ${selectedCity.state}');

                  setState(() {
                    _cityController.text = selectedCity.city;
                    _stateController.text = selectedCity.state;
                    _countryController.text = selectedCity.country;
                    _zipcodeController.text = "5454";

                    _addressController.text =
                        "${selectedCity.city}${selectedCity.state}${selectedCity.country}5454";
                  });
                },
              ),
              // _buildTextField(
              //   controller: _cityController,
              //   label: 'City',
              //   hint: 'Enter city',
              // ),
              // const SizedBox(height: 16),

              // _buildTextField(
              //   controller: _addressController,
              //   label: 'Address',
              //   hint: 'Enter address',
              //   maxLines: 2,
              // ),

              // const SizedBox(height: 16),
              // _buildTextField(
              //   controller: _stateController,
              //   label: 'State',
              //   hint: 'Enter state',
              // ),
              // const SizedBox(height: 16),
              // _buildTextField(
              //   controller: _countryController,
              //   label: 'Country',
              //   hint: 'Enter country',
              // ),
              // const SizedBox(height: 16),
              // _buildTextField(
              //   controller: _zipcodeController,
              //   label: 'Zipcode',
              //   hint: 'Enter zipcode',
              //   keyboardType: TextInputType.number,
              // ),
              const SizedBox(height: 24),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return state.isLoading
                      ? Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : _buildSubmitButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null
                  ? 'Select Date'
                  : DateFormat('MMM dd, yyyy').format(_selectedDate!),
              style: TextStyle(
                color: _selectedDate == null ? Colors.grey : Colors.black,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isFormValid ? _submitForm : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Create Event',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
