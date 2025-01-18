class CreateEventRequest {
  final String name;
  final String category;
  final DateTime date;
  final String city;
  final String address;
  final String state;
  final String country;
  final String zipcode;

  CreateEventRequest({
    required this.name,
    required this.category,
    required this.date,
    required this.city,
    required this.address,
    required this.state,
    required this.country,
    required this.zipcode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'date': date.toUtc().toIso8601String(),
      'city': city,
      'address': address,
      'state': state,
      'country': country,
      'zipcode': zipcode,
    };
  }
}

// API response model
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
}
