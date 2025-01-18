import 'participant.dart';

class Event {
  final String id;
  final String title;
  final DateTime date;
  final bool isActive;
  final List<Participant> participants;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.isActive,
    required this.participants,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      isActive: json['isActive'],
      participants: (json['participants'] as List)
          .map((p) => Participant.fromJson(p))
          .toList(),
    );
  }
}