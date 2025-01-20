import 'package:flutter/material.dart';

class LocationInfoCard extends StatelessWidget {
  final String address;
  final String state;
  final String country;
  final String zipcode;

  const LocationInfoCard({
    super.key,
    required this.address,
    required this.state,
    required this.country,
    required this.zipcode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Address:', address),
            const SizedBox(height: 8),
            _buildInfoRow('State:', state),
            const SizedBox(height: 8),
            _buildInfoRow('Country:', country),
            const SizedBox(height: 8),
            _buildInfoRow('Zipcode:', zipcode),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
