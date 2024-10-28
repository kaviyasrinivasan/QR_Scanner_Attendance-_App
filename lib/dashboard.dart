import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();

  // Collection reference for events in Firestore
  final CollectionReference _eventsCollection =
  FirebaseFirestore.instance.collection('events');

  void _addEvent() async {
    if (_eventNameController.text.isNotEmpty &&
        _venueController.text.isNotEmpty) {
      await _eventsCollection.add({
        'eventName': _eventNameController.text,
        'venue': _venueController.text,
      });
      _eventNameController.clear();
      _venueController.clear();
      setState(() {}); // Refresh the state to show new events
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Attendance App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _venueController,
              decoration: InputDecoration(labelText: 'Venue'),
            ),
          ),
          ElevatedButton(
            onPressed: _addEvent,
            child: Text('Add Event'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _eventsCollection.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final events = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return ListTile(
                      title: Text(event['eventName']),
                      subtitle: Text(event['venue']),
                      onTap: () {
                        String filePath = '${event['eventName']}_attendance.xlsx'; // Adjust the path generation as needed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailPage(
                              eventName: event['eventName'],
                              venue: event['venue'],
                              filePath: filePath, // Pass the generated filePath here
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
