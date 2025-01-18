class Participant {
  final String id;
  final String name;
  final String corner; // 'red' or 'blue'

  Participant({
    required this.id,
    required this.name,
    required this.corner,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      corner: json['corner'],
    );
  }
}