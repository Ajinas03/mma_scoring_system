import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/auth/auth_bloc.dart';
import 'package:my_app/screen/auth/widget/custom_dropdown_widget.dart';
import 'package:my_app/screen/common/text_widget.dart';

import 'widget/custom_indput_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'fname': '',
    'lname': '',
    'email': '',
    'phone': '',
    'role': '',
    'password': '',
    'city': '',
    'state': '',
    'country': '',
    'zipcode': '',
  };

  final List<String> _roles = ['admin', 'player', 'jury', 'referee'];

  bool get _isFormValid => _formData.values.every((value) => value.isNotEmpty);

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      print(_formData);
      context.read<AuthBloc>().add(
            SignupEvent(
              fname: _formData['fname']!,
              lname: _formData['lname']!,
              email: _formData['email']!,
              phone: _formData['phone']!,
              role: _formData['role']!,
              password: _formData['password']!,
              city: _formData['city']!,
              state: _formData['state']!,
              country: _formData['country']!,
              zipcode: _formData['zipcode']!,
              context: context,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Sign Up'),
      ),
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
                ),
                CustomInputField(
                  label: 'Last Name',
                  value: _formData['lname'],
                  onChanged: (value) =>
                      setState(() => _formData['lname'] = value),
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
                ),
                CustomDropdown(
                  label: 'Role',
                  value: _formData['role'],
                  items: _roles,
                  onChanged: (value) =>
                      setState(() => _formData['role'] = value ?? ''),
                ),
                CustomInputField(
                  label: 'Password',
                  value: _formData['password'],
                  isPassword: true,
                  onChanged: (value) =>
                      setState(() => _formData['password'] = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  label: 'City',
                  value: _formData['city'],
                  onChanged: (value) =>
                      setState(() => _formData['city'] = value),
                ),
                CustomInputField(
                  label: 'State',
                  value: _formData['state'],
                  onChanged: (value) =>
                      setState(() => _formData['state'] = value),
                ),
                CustomInputField(
                  label: 'Country',
                  value: _formData['country'],
                  onChanged: (value) =>
                      setState(() => _formData['country'] = value),
                ),
                CustomInputField(
                  label: 'Zipcode',
                  value: _formData['zipcode'],
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      setState(() => _formData['zipcode'] = value),
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? Align(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(
                                text: state.signUpError ?? "",
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: state.signUpError != null ? 10 : 0,
                              ),
                              ElevatedButton(
                                onPressed: _isFormValid ? _onSubmit : null,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Sign Up'),
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Already have an account? Sign In'),
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
