import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add an event
  Future<void> addEvent(String eventName, String venue) async {
    await _firestore.collection('events').add({
      'eventName': eventName,
      'venue': venue,
      'createdAt': Timestamp.now(),
    });
  }

  // Function to get events
  Stream<List<Map<String, dynamic>>> getEvents() {
    return _firestore.collection('events').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => {
          'id': doc.id,
          'eventName': doc['eventName'],
          'venue': doc['venue'],
        }).toList());
  }
}
