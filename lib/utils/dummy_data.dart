import '../models/event.dart';
import '../models/participant.dart';

class DummyData {
  static List<Event> getEvents() {
    return [
      Event(
        id: '1',
        title: 'MMA Championship 2024',
        date: DateTime.now().add(const Duration(days: 2)),
        isActive: true,
        participants: [
          Participant(id: '1', name: 'John Smith', corner: 'red'),
          Participant(id: '2', name: 'Mike Johnson', corner: 'blue'),
        ],
      ),
      Event(
        id: '2',
        title: 'Kickboxing Elite',
        date: DateTime.now(),
        isActive: true,
        participants: [
          Participant(id: '3', name: 'Alex Rivera', corner: 'red'),
          Participant(id: '4', name: 'Chris Lee', corner: 'blue'),
        ],
      ),
      Event(
        id: '3',
        title: 'Fight Night Series',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isActive: false,
        participants: [
          Participant(id: '5', name: 'Sarah Connor', corner: 'red'),
          Participant(id: '6', name: 'Maria Rodriguez', corner: 'blue'),
        ],
      ),
    ];
  }

  static List<Map<String, dynamic>> getReferees() {
    return [
      {
        'id': 'ref1',
        'name': 'Robert Wilson',
        'position': 'Left Corner',
        'isMainJury': false,
      },
      {
        'id': 'ref2',
        'name': 'David Brown',
        'position': 'Right Corner',
        'isMainJury': false,
      },
      {
        'id': 'ref3',
        'name': 'James Davis',
        'position': 'Back Corner',
        'isMainJury': false,
      },
      {
        'id': 'jury1',
        'name': 'Michael Anderson',
        'position': 'Main Jury',
        'isMainJury': true,
      },
    ];
  }
}