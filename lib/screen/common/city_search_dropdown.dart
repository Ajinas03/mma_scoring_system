import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CitySearchDropdown extends StatefulWidget {
  final Function(Result) onCitySelected;

  const CitySearchDropdown({super.key, required this.onCitySelected});

  @override
  _CitySearchDropdownState createState() => _CitySearchDropdownState();
}

class _CitySearchDropdownState extends State<CitySearchDropdown> {
  final TextEditingController _searchController = TextEditingController();
  List<Result> _cityResults = [];
  bool _isLoading = false;

  Future<void> _searchCities(String query) async {
    if (query.length < 2) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://masternode-856921708890.asia-south1.run.app/api/v1.0/addresssearch'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'establishment': '', 'address': '', 'city': query}),
      );

      if (response.statusCode == 200) {
        final addressResultModel =
            AddressResultModel.fromJson(json.decode(response.body));
        setState(() {
          _cityResults = addressResultModel.results;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch cities')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search City',
            suffixIcon: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(Icons.search),
          ),
          onChanged: _searchCities,
        ),
        if (_cityResults.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _cityResults.length,
              itemBuilder: (context, index) {
                final city = _cityResults[index];
                return ListTile(
                  title: Text('${city.city}, ${city.state}'),
                  subtitle: Text(city.country),
                  onTap: () {
                    _searchController.text =
                        '${city.city}, ${city.state}'; // Fill selected value
                    widget.onCitySelected(city);
                    setState(() {
                      _cityResults.clear();
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

// Model Classes
class AddressResultModel {
  List<Result> results;

  AddressResultModel({required this.results});

  factory AddressResultModel.fromJson(Map<String, dynamic> json) =>
      AddressResultModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String city;
  String state;
  String country;

  Result({required this.city, required this.state, required this.country});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
      };
}
